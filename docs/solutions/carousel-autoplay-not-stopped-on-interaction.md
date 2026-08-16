# CarouselViewNode autoplay kept running after the user tapped/dragged it

**File(s):** `lib/src/snippet/snodes/carousel_view_node.dart`

## Problem
When `autoPlay: true`, `_AutoPlayingCarouselView` (the runtime wrapper that
drives autoplay via a `Timer`-based `CarouselController.animateTo()`, added
in [carousel-view-autoplay-not-implemented.md](./carousel-view-autoplay-not-implemented.md))
kept auto-advancing even after the user had tapped an item or manually
dragged the carousel — fighting the user's own interaction instead of
getting out of the way.

## Root Cause
`_AutoPlayingCarouselViewState` had no interaction awareness at all: its
`Timer.periodic` just kept firing `_advance()` on a fixed interval
regardless of anything the user did to the carousel in the meantime. There
was no listener of any kind on user gestures.

## Fix & Strategy
- Added a `bool _userInteracted` flag and a `_stopAutoPlayOnUserInteraction()`
  method that cancels the timer (once, permanently — not paused/resumable)
  the first time it's called.
- Wrapped the `CarouselView.weighted` in a
  `Listener(onPointerDown: (_) => _stopAutoPlayOnUserInteraction(), ...)`.
  A single `onPointerDown` hook is sufficient for both "tap" and "starts
  scrolling" — a drag necessarily begins with a pointer-down on the widget,
  so there's no need for a separate `NotificationListener<ScrollNotification>`
  to distinguish the two gesture types.
- `_restartTimer()` (called from both `initState` and `didUpdateWidget`,
  the latter re-firing whenever `autoPlay`/`autoPlayIntervalSecs`/child
  count change) now also checks `_userInteracted` before scheduling a new
  timer, so a later prop change can't resurrect autoplay after the user
  has taken over.
- Deliberately *not* stopped by `_advance()`'s own `controller.animateTo()`
  calls — those are programmatic scroll animations with no associated
  pointer event, so they never reach `onPointerDown` and don't trip the
  same guard that a real user gesture does.

## Workarounds & Trade-offs
- Once stopped, autoplay never resumes for that widget instance (no
  "resume after N seconds of inactivity" behavior) — resuming mid- or
  post-interaction would fight the user's own scroll position, which is
  worse than just leaving it stopped.
