# build_runner failed after adding NamedWidgetNode

**File(s):** `lib/src/snippet/snodes/named_widget_node.dart`, `lib/fsdui.dart`

## Problem

After adding a new `NamedWidgetNode` SNode subclass, `dart run build_runner
build` failed outright (0 outputs written) with errors like:

```
E dart_mappable_builder on lib/src/snippet/snodes/wrap_node.dart:
  Cannot include subclass class NamedWidgetNode extends SNode, since it has
  no generated mapper.
```

repeated once per file that (transitively) imports `snode.dart` — the
builder aborted the whole run rather than just skipping `NamedWidgetNode`.

## Root Cause

Two of the five steps from this repo's "Adding a New SNode Type" checklist
(see `CLAUDE.md`) had been done, but a third was missed:

1. `NamedWidgetNode` was already listed in `SNode`'s discriminated-union
   declaration in `snode.dart`:
   ```dart
   @MappableClass(
     discriminatorKey: 'DK:snode',
     includeSubClasses: [
       // childless
       NamedWidgetNode,
       ...
   ```
2. The class body already declared `with NamedWidgetNodeMappable` and had
   `part 'named_widget_node.mapper.dart';` — both of which only make sense
   if the class is meant to be `dart_mappable`-generated.
3. **But the class itself was missing the `@MappableClass()` annotation.**
   Without it, `dart_mappable_builder` has nothing to generate a mapper
   from — so when it tried to resolve `NamedWidgetNode` as one of `SNode`'s
   `includeSubClasses`, it found no mapper for it and failed the whole
   build (not just that one file).

A second, related bug was found while fixing this: `fsdui.dart`'s mapper
initialization list called
```dart
NamedWidgetNode.ensureInitialized();
```
but `ensureInitialized()` is a static method on the **generated mapper
class** (`NamedWidgetNodeMapper`), not on the node class itself — every
other entry in that list follows the `XyzNodeMapper.ensureInitialized()`
pattern.

## Strategy

- Added the missing `@MappableClass()` annotation directly above
  `class NamedWidgetNode extends SNode with NamedWidgetNodeMappable`.
- Fixed the initialization call to `NamedWidgetNodeMapper.ensureInitialized();`.
- Re-ran `dart run build_runner build --delete-conflicting-outputs`, which
  then generated `named_widget_node.mapper.dart` and succeeded.

**Takeaway:** when `dart_mappable_builder` reports "class X ... has no
generated mapper" for a class you just added, check the class declaration
for a missing `@MappableClass()` first — `with XyzNodeMappable` and the
`part '....mapper.dart';` directive will both be present and look correct
even when the annotation itself is missing, since neither of those actually
requires the generated file to exist to *parse*.
