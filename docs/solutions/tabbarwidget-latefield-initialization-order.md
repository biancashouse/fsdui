# TabBarWidgetState never successfully published its TabController

**File(s):** `lib/src/snippet/snodes/tabbar_node.dart`

## Problem
`TabBarViewNode` was permanently stuck rendering nothing (or a "no
TabBarNode found" error) — its `ValueListenableBuilder` on
`TabBarNode.tabCNotifier` never saw a non-null `TabController`, no matter
how the surrounding widget tree was restructured.

## Root Cause
`TabBarWidgetState.initState()` deferred its setup into a single
`fsdui.afterNextBuildDo()` callback, but the two statements inside it were
in the wrong order:

```dart
fsdui.afterNextBuildDo((){
  widget.node.tabC = _tabC;               // reads _tabC ...
  _tabC = TabController(vsync: this, ...); // ... before this ever runs
  _tabC.addListener(_tabListenerF);
});
```

`_tabC` is declared `late TabController _tabC;` — reading it before it has
ever been assigned throws `LateInitializationError`. The very first line
of the callback read `_tabC` to assign it onto `widget.node.tabC`, before
the second line had created it. This threw on every single run, so
`widget.node.tabC` (the `ValueNotifier` that `TabBarViewNode` listens to)
was never successfully set — the exception was swallowed by the framework
zone that runs post-frame callbacks, so it produced no visible crash, just
permanent silence.

Separately, `_tabC` being created inside a *deferred* callback was also
wrong on its own: `TabBarWidget.build()` reads `_tabC` synchronously (`
TabBar(controller: _tabC, ...)`), and `build()` always runs before any
`afterNextBuildDo` callback fires (deferred callbacks run *after* the
current frame completes). So even fixing just the ordering without also
moving the creation out of the deferred callback would still crash on the
very first frame.

## Fix & Strategy
- Create `_tabC` synchronously in `initState()`, not inside the deferred
  callback — `build()` needs it on the first frame.
- Keep only the `widget.node.tabC = _tabC;` notifier assignment deferred
  via `afterNextBuildDo()` (this part genuinely needs to happen after the
  frame completes, since it can trigger `setState` on a listening
  `ValueListenableBuilder`, which isn't legal mid-build).

## Workarounds & Trade-offs
None — this was a straightforward statement-ordering defect with a direct
fix; no behavioral trade-offs involved.
