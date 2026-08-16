# build_runner crashed after upgrading Flutter/Dart SDK

**File(s):** `pubspec.yaml`, `lib/src/bloc/capi/capi_state.dart`,
`lib/src/bloc/poll/poll_event.dart`, `lib/src/bloc/poll/poll_state.dart`

## Problem

After upgrading to Flutter 3.47.0 / Dart 3.13.0, `dart run build_runner
build` crashed while analyzing `lib/fsdui.dart`:

```
E freezed on lib/fsdui.dart:
  Exception: Missing implementation of visitDotShorthandPropertyAccess
  #0  ThrowingAstVisitor._throw (package:analyzer/dart/ast/visitor.dart:2971:5)
  #1  ThrowingAstVisitor.visitDotShorthandPropertyAccess (...)
  ...
```

Also visible just before the crash:

```
W SDK language version 3.13.0 is newer than `analyzer` language version 3.9.0.
```

## Root Cause

The locked `analyzer` package (7.6.0, per `pubspec.lock`) only understands
Dart language syntax up to version 3.9. Dart 3.13 introduced new syntax
("dot shorthands", e.g. `Color x = .red;`) whose AST node type
(`DotShorthandPropertyAccess`) that old `analyzer` has no visitor
implementation for — it hits the `ThrowingAstVisitor` base-class fallback and
crashes outright the moment it encounters that syntax anywhere in the
transitive closure it's summarizing (in this case, somewhere under the SDK's
own widget libraries pulled in via `lib/fsdui.dart`).

`analyzer` itself is only a transitive dependency here (via `build_runner`,
`custom_lint`, `source_gen`, etc.), and the project's dev-tooling
dependencies (`build_runner: ^2.5.4`, `custom_lint: any`, `freezed_lint:
any`, `freezed: ^2.5.7`, ...) were old enough that pub's constraint solver
couldn't move `analyzer` forward even within otherwise-compatible ranges —
`flutter pub upgrade` alone reported "No dependencies changed."

## Fix & Strategy

Ran a **scoped** major-version upgrade — only the codegen/dev-tooling
packages, not the runtime `dependencies:` (go_router, flutter_quill, etc.,
which weren't implicated and carry their own unrelated breaking-change
risk):

```
dart pub upgrade --major-versions --unlock-transitive \
  build_runner custom_lint freezed_lint freezed freezed_annotation \
  json_serializable json_annotation dart_mappable_builder \
  built_value_generator built_value flutter_lints
```

This pulled `analyzer` 7.6.0 → 8.4.0 (enough to parse the new syntax) and,
as a side effect, forced `freezed` across its 2.x → 3.x major version
boundary (`^2.5.7` → `^3.2.3` in `pubspec.yaml`).

Freezed 3.x requires `@freezed`-annotated classes to be declared `abstract`
(previously a plain `class` sufficed, backed by the generated mixin). Without
that, `dart analyze`/`build_runner` reports "Missing concrete
implementations of ... Try implementing the missing methods, or make the
class abstract." Fixed by adding `abstract` to:

- `CAPIState` (`lib/src/bloc/capi/capi_state.dart`)
- `PollEvent` (`lib/src/bloc/poll/poll_event.dart`)
- `PollState` (`lib/src/bloc/poll/poll_state.dart`) — didn't actually error
  under the old freezed either, see below, but needed the same fix for
  correctness once cleaned up.

`PollEvent` and `PollState` had accumulated hand-written
`@override ... => throw UnimplementedError();` stubs for every
freezed-generated field/method — an old workaround for the same
"class isn't abstract" requirement, done by manually implementing the
missing members instead of marking the class `abstract`. These were dead
code even before this fix: freezed's `factory Foo(...) = _Foo;` pattern
means every real instance is of the generated `_Foo` subclass (which
`extends` the annotated class and provides the real implementations) — the
annotated class's own overrides are never reached by any actual instance.
Deleted them once `abstract` made them unnecessary.

## Workarounds & Trade-offs

- Chose a **scoped** dependency upgrade (dev-tooling only) over a full
  `dart pub upgrade --major-versions` across every dependency, to keep the
  blast radius limited to what was actually causing the failure. A full
  upgrade would touch ~45 packages including runtime UI dependencies with
  their own unrelated breaking-change risk (`go_router`, `flutter_quill`,
  etc.) — deliberately left alone.
- `analyzer` landed at 8.4.0, not the latest available (14.1.0) — pub's
  solver picked the lowest version satisfying every constraint in the
  scoped upgrade. Good enough to fix this crash; a future `build_runner`
  failure after a further SDK bump may need this revisited.

## Follow-up (attempted, reverted)

`environment.sdk` in `pubspec.yaml` was still `^3.9.0` after the above —
`pub get` had no trouble resolving against it (it's a lower bound, and
3.13.0 satisfies `^3.9.0` fine), so it wasn't the cause of the crash. It
looked stale though, so it was tried as a cleanup: bumped to `sdk: ^3.13.0`
to match the actual Dart version now in use.

**That broke `flutter test`** with a wave of `Can't have modifier 'final'
here` parse errors across unrelated existing files (`firestore_model_repo.dart`,
`model_repo.dart`, `zoomer.dart`, `offset_model.dart`,
`pkg_step_widget.dart`, and the freezed-generated `capi_state.freezed.dart`
/ `poll_state.freezed.dart`) — all using the ordinary, valid
`final Type paramName` parameter-modifier syntax. Raising
`environment.sdk`'s lower bound raises the *default language version*
resolved for this package's own files (recorded in
`.dart_tool/package_config.json` after `pub get`), and something in this
exact Dart 3.13.0 build's frontend cannot parse plain `final` parameter
modifiers once a file's language version is pinned at 3.13. **Reverted to
`sdk: ^3.9.0`** — the version this package's files are actually written
against, and the one that makes `flutter test` pass. Bumping it further is
a separate piece of work (would need every `final`-parameter call site
identified and fixed first), not a required part of this build_runner fix.
