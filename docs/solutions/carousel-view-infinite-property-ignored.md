# CarouselViewNode ignored its own `infinite` property

**File(s):** `lib/src/snippet/snodes/carousel_view_node.dart`

## Problem

Toggling the `infinite` property on a `CarouselViewNode` in the editor had
no visible effect on the rendered carousel — it always behaved as if
`infinite` were on.

## Root Cause

`buildFlutterWidget` passed a literal `true` to the underlying `CarouselView`
constructor instead of the node's actual field:

```dart
child: CarouselView(
    key: createNodeWidgetGK(),
    padding: padding,
    backgroundColor: backgroundColor,
    infinite: true, // <- hardcoded, ignores this.infinite
    elevation: elevation,
    ...
```

So the `infinite` property existed, had its own `BoolPNode` editor, and was
persisted — but the value was never actually read when building the widget.

Found incidentally while investigating why autoplay didn't work (see
[carousel-view-autoplay-not-implemented.md](./carousel-view-autoplay-not-implemented.md)).

## Strategy

Passed the real field through: `infinite: infinite`.
