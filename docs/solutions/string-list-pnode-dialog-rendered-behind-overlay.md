# StringListPNode's dialog rendered behind the app's overlay stack

**File(s):** `lib/src/snippet/pnodes/editors/property_button_string_list.dart`

## Problem

`StringListPNode`'s reorderable list editor (used to edit properties like
`PageViewNode.childSnippetNames`) was first implemented using a plain
Flutter `showDialog`. The dialog didn't appear usable — taps didn't
register and text fields couldn't be focused, as if something else was
sitting on top of it.

## Root Cause

This app has its own overlay/callout system (`fsdui.showOverlay`, backed by
the `flutter_callouts` package) that every other property editor in the
codebase already uses — `ColorPNode`, `EdgeInsetsPNode`, the properties side
panel itself, etc. That system inserts `OverlayEntry`s **directly** into the
shared root `OverlayState`, entirely outside of `Navigator`'s route
bookkeeping:

```dart
fca.overlayState?.insert(entry, below: lowestOverlay); // appended at absolute top
```

`showDialog()`, in contrast, pushes a `DialogRoute` through
`Navigator.of(context)`. Navigator positions newly-pushed routes relative to
its **own** previously-tracked route entries — not "absolute top of the
overlay list." Since the properties panel and other callouts had already
been inserted directly into the `OverlayState` above that tracked point, the
dialog route landed **underneath** them, even though it was the
most-recently-added widget in wall-clock terms.

The properties side panel itself doesn't even go through `showOverlay` — it
inserts its own raw `OverlayEntry` directly (`Overlay.of(context).insert(...)`
in `snippet_editor_side_panel.dart`), reinforcing that this app's convention
is to bypass `Navigator`-based overlays entirely for in-editor UI.

## Strategy

Reverted to the app's own `fsdui.showOverlay` / `PropertyCalloutButton`
pattern instead of `showDialog`. General rule established for this
codebase: any new popover/editor UI must go through `fsdui.showOverlay`
(or a wrapper like `PropertyCalloutButton`), not Flutter's built-in
route-based overlay APIs — `showDialog`, `showMenu`, `PopupMenuButton`,
`DropdownButton` — since all of those push a `Navigator` route and would hit
the same stacking problem. `MenuAnchor` was later confirmed safe to use
inside these callouts (it renders via `OverlayPortal`, which inserts
directly into the nearest `Overlay` rather than pushing a route), and was
used for the page-snippet picker rows added afterward.
