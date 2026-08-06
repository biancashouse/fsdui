# CarouselViewNode's `overlayColor` property was never applied

**File(s):** `lib/src/snippet/snodes/carousel_view_node.dart`

## Problem

`CarouselViewNode.overlayColor` had its own `ColorPNode` editor and stored
whatever value the user picked, but changing it had no visible effect on
the rendered carousel.

## Root Cause

`overlayColor` was declared as a field and exposed for editing, but was
never actually passed to the `CarouselView(...)` widget constructor —
`buildFlutterWidget` simply omitted it from the argument list, so the value
was silently dropped every time the widget was built.

A secondary factor: `CarouselView.overlayColor` is typed as
`WidgetStateProperty<Color?>?`, not a plain `Color?` — so even a naive fix
of adding `overlayColor: overlayColor` would not have compiled without
adapting the type.

Found incidentally while investigating why autoplay didn't work (see
[carousel-view-autoplay-not-implemented.md](./carousel-view-autoplay-not-implemented.md)).

## Strategy

Wired the field through, wrapping the plain `Color?` in
`WidgetStatePropertyAll(overlayColor)` to satisfy `CarouselView`'s expected
type:

```dart
overlayColor: widget.overlayColor != null
    ? WidgetStatePropertyAll(widget.overlayColor)
    : null,
```
