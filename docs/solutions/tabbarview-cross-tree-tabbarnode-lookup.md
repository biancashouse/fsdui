# TabBarViewNode couldn't find its TabBarNode across separate SnippetBuilder trees

**File(s):** `lib/src/snippet/snodes/tabbarview_node.dart`,
`lib/src/snippet/snodes/tabbar_node.dart`, `lib/fsdui.dart`,
`lib/src/api/snippet_builder/snippet_builder.dart`

## Problem
A consuming app wanted a common "pinned tab bar" layout: `TabBarNode`
placed in a `SliverAppBar.bottom` (pinned while scrolling), with
`TabBarViewNode` scrolling separately in a sibling `SliverFillRemaining`.
`TabBarViewNode` rendered a permanent `Error(errorMsg: 'No TabBarNode
found in snippet tree.')`. The initial hypothesis (from the consuming
app) was a build-order race — "TabBarViewNode is constructed before its
TabBarNode" — but no amount of reordering widgets fixed it.

## Root Cause
Two independent, compounding issues:

1. **Wrong lookup mechanism for this layout.** `TabBarViewNode.tabBarNode`
   found its `TabBarNode` via `rootNodeOfSnippet()?.findDescendant(TabBarNode)`
   — i.e. by walking up the *SNode* ancestry to the nearest named root,
   then searching its descendants. `SNode.isASnippetRoot` is `true`
   whenever `name != null`, and `TabBarViewNode` itself has a `name` (it's
   the `initialValue` of its own `SnippetBuilder`) — so `rootNodeOfSnippet()`
   returned `TabBarViewNode` itself immediately, without ever climbing
   toward `TabBarNode`'s tree. Since `TabBarNode` and `TabBarViewNode` were
   each the root of their *own* independent `SnippetBuilder` (different
   `name`s, rendered in different Flutter widget subtrees —
   `SliverAppBar.bottom` vs `SliverFillRemaining`), there was no shared
   named ancestor to find *regardless of build order*. This is a
   structural mismatch, not a timing bug — see
   [tabbarwidget-latefield-initialization-order.md](./tabbarwidget-latefield-initialization-order.md)
   for a real, separate timing bug found while investigating this.
2. **`SliverAppBar.bottom` requires a `PreferredSizeWidget`**, and
   `SnippetBuilder` (needed to render `TabBarNode` from a snippet) only
   returns a plain `Widget` — this is what motivated splitting the two
   nodes into separate `SnippetBuilder`s in the first place.

## Fix & Strategy
- Added `PreferredSizeSnippetBuilder` (in `snippet_builder.dart`) — a thin
  wrapper implementing `PreferredSizeWidget`, taking an explicit
  `preferredSize` to reserve (the snippet's real height isn't known
  synchronously, since its content can load asynchronously from
  cache/Firestore). This unblocks the "TabBarNode pinned in
  SliverAppBar.bottom" layout without needing `SnippetBuilder` itself to
  change shape.
- Replaced the ancestry-only lookup with a **name-based, reactive**
  lookup for cross-tree cases:
  - `fsdui.tabBarNodeNotifierFor(name)` (in `fsdui.dart`) returns a
    `ValueNotifier<TabBarNode?>`, created lazily per name — not a plain
    `Map`, because either node's widget can mount first. A one-shot map
    read done during `build()` would be `null` and stay wrong forever if
    it ran before the `TabBarNode` had registered; the notifier lets
    `TabBarViewNode` reactively wait and rebuild once it shows up.
  - `TabBarWidgetState` publishes `widget.node` into that notifier
    (deferred via `afterNextBuildDo`, alongside the existing `tabC`
    assignment — for the same "not legal mid-build" reason) and clears it
    in `dispose()` (see the dispose-timing addendum below — clearing it
    turned out to need deferring too, not just the initial publish).
  - `TabBarViewNode` gained an optional `tabBarName` field. When set,
    `buildFlutterWidget` wraps in a `ValueListenableBuilder` on
    `fsdui.tabBarNodeNotifierFor(tabBarName!)`, rendering
    `SizedBox.shrink()` until the node appears, then delegating to the
    existing `tabCNotifier`-driven body (factored into
    `_buildWithTabBar()`, shared with the original ancestry path). When
    `tabBarName` is null, the original ancestry-based lookup is used
    unchanged, for same-tree layouts.
- `TabBarViewNode` is `@MappableClass()`; adding `tabBarName` required
  regenerating `dart_mappable` codegen
  (`dart run build_runner build --delete-conflicting-outputs`).

## Workarounds & Trade-offs
- The by-name registry is intentionally opt-in (`tabBarName` null by
  default) rather than replacing the ancestry lookup outright, to avoid
  changing behavior for existing same-tree `TabBarNode`/`TabBarViewNode`
  usages.
- Because `TabBarNode`/`TabBarViewNode` are each independently persisted
  by name via `SnippetBuilder`, a snippet with a given name that was
  already cached/persisted *before* the `tabBarName` field existed will
  deserialize with `tabBarName: null` and silently fall back to the
  (broken, for this layout) ancestry path — the code fix alone isn't
  sufficient if a stale snippet is already cached under the same name.
  See the consuming app's own docs/solutions for the concrete case this
  caused.

## Addendum: `dispose()` clearing the notifier hit the same lock, from the other end
After the above shipped, the app hit a new, related crash:
`FlutterError: setState() or markNeedsBuild() called when widget tree was
locked`, naming `ValueListenableBuilder<TabBarNode?>` as the widget, with
`TabBarWidgetState.dispose` in the stack trace.

**Root Cause:** `dispose()` cleared the notifier synchronously
(`notifier.value = null`), on the (wrong) assumption that `dispose()` only
ever runs between frames, so a synchronous listener notification would be
safe there the same way it's safe once a frame has fully finished. In
fact Flutter can call `State.dispose()` *mid-build*, while reconciling the
element tree — e.g. when an old `TabBarNode` widget is being swapped out
for a new one within the same `buildScope()` pass — so the notification
fired while the framework was still locked.

**Fix:** Deferred the notifier-clearing (and the pre-existing, identically
hazardous `widget.node.tabC = null` line) to
`WidgetsBinding.instance.addPostFrameCallback`, capturing `widget.node`,
`node.name`, and the disposed `_tabC` into local variables first — `widget`
is gone once `dispose()` returns, so the callback can't reference it
directly. The deferred callback also compares identity
(`node.tabC == disposedTabC` / `notifier.value == node`) before clearing,
since by the time it runs a *replacement* `TabBarWidgetState` for the same
name may have already registered itself, and the old, disposed instance's
deferred cleanup must not clobber it.

**Lesson:** `initState()` and `dispose()` are symmetric in this respect —
both can run synchronously mid-build, so any side effect in either that
can notify a listener elsewhere in the tree needs the same
post-frame-deferral treatment, not just one of the two.

