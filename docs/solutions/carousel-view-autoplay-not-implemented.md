# CarouselViewNode never autoplayed, even with `infinite: true`

**File(s):** `lib/src/snippet/snodes/carousel_view_node.dart`

## Problem

`infinite: true` was expected to make `CarouselViewNode` autoplay (advance
through its items on its own). It never did.

## Root Cause

This turned out not to be a code bug but an incorrect assumption about
Flutter's own `CarouselView` (Material 3) widget. Per its official API docs:

> "When infinite is true, the carousel will create an infinite loop of
> items, allowing continuous scrolling in both directions."

`infinite` only means manual scroll gestures never hit an edge — it has
nothing to do with automatic advancement. `CarouselView`'s full property
list (`consumeMaxWeight`, `itemExtent`, `shrinkExtent`, `itemSnapping`,
`reverse`, `controller`, `scrollDirection`, `onTap`, `backgroundColor`,
`overlayColor`, `elevation`, `shape`, `padding`, `enableSplash`, `infinite`,
`allowFullyExpand`, `children`) has no `autoPlay`/`autoPlayInterval` at all.

The codebase's older `CarouselNode` (now retired) wrapped the third-party
`carousel_slider` package, which *does* have real `autoPlay`/
`autoPlayInterval` support — but `CarouselViewNode` was built on top of
Flutter's newer `CarouselView` as its replacement, and autoplay was never
re-implemented for it. No autoplay logic existed anywhere in
`CarouselViewNode` prior to this fix (an earlier, fully dead/commented-out
`_AutoPlayingListView` class only did a one-time slide-in animation on
`initState`, not a repeating timer).

Before implementing anything, the assumption was checked directly against
Flutter's published docs rather than taken at face value.

## Strategy

Implemented real autoplay via a new `_AutoPlayingCarouselView` wrapper
around `CarouselView`:

- A `CarouselController` (which extends `ScrollController`) is created and
  passed to `CarouselView.controller`.
- A `Timer.periodic` (interval driven by a new `autoPlayIntervalSecs`
  property) calls `_advance()` each tick, which `animateTo`s the controller
  forward by one `itemExtent`.
- If `infinite` is off and that would overshoot the end, it loops back to
  `0` instead — so autoplay works whether or not infinite scrolling is
  enabled.
- The timer restarts in `didUpdateWidget` whenever `autoPlay`,
  `autoPlayIntervalSecs`, or the item count changes, so editing those
  properties live in the editor takes effect immediately.
- Added `autoPlay` (bool) and `autoPlayIntervalSecs` (double) fields +
  corresponding `BoolPNode`/`DecimalPNode` editors on `CarouselViewNode`.

See also: [carousel-view-infinite-property-ignored.md](./carousel-view-infinite-property-ignored.md)
and [carousel-view-overlay-color-not-applied.md](./carousel-view-overlay-color-not-applied.md),
two unrelated bugs found incidentally while doing this work.
