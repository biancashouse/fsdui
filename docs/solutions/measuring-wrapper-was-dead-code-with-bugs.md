# MeasuringWrapper was commented-out dead code with two latent bugs

**File(s):** `lib/src/measuring/measuring_wrapper.dart`

## Problem

`MeasuringWrapper` — a `RenderProxyBox`-based widget meant to continuously
report a wrapped child's size/position as layout re-runs — existed only as
commented-out code, unused and unexported. The user asked to uncomment it so
size is calculated continuously (as opposed to `SelfSizingStateMixin`'s
one-shot measurement). Uncommenting as-is would have shipped two bugs.

## Root Cause

1. **Size reporting was gated behind position reporting.** The original
   logic nested all size-change detection inside `if (onPosChange != null)`:

   ```dart
   if (onPosChange != null) {
     Offset newPos = child!.localToGlobal(Offset.zero);
     if (oldSize == newSize && oldPos == newPos) return;
     if (oldSize != newSize) {
       oldSize = newSize;
       onSizeChange(newSize);
     }
     ...
   }
   ```

   Since `onPosChangedF` was documented as optional ("may just want size"),
   any caller who only wanted size and passed `onPosChangedF: null` would
   never have `onSizeChangedF` called at all — the size branch was
   unreachable without also opting into position tracking.

2. **No `updateRenderObject` override.** `createRenderObject` is called once
   per `Element`; without `updateRenderObject`, every rebuild's fresh
   callback closures (commonly inline closures capturing the enclosing
   `State`, e.g. `onSizeChangedF: (s) => setState(...)`) would be silently
   discarded in favor of the very first build's closures, permanently.

Also fixed while uncommenting: referenced the old `fco` singleton, which no
longer exists (`fsdui` is the current one).

## Fix & Strategy

- Moved size-change detection out from under the `onPosChange != null` guard
  so it always runs; position detection stays conditional on
  `onPosChange != null`.
- Added `updateRenderObject` to `MeasuringWrapper`, reassigning the render
  object's (now non-`final`) callback fields on every rebuild.
- Made `onPosChangedF` a genuinely optional named parameter (default `null`)
  instead of `required` — the type was already nullable, so forcing callers
  to write `onPosChangedF: null` explicitly added no value.
- `fco` → `fsdui`.

Verified with a throwaway widget test: a child wrapped in `MeasuringWrapper`
resizes via its own `setState` (the wrapper itself is never recreated), and
`onSizeChangedF` fires again with the new size — confirming continuous
(not one-shot) behavior and that the `updateRenderObject` fix keeps the
latest callback closure live.

## Workarounds & Trade-offs

None — straightforward bug fixes with no behavioral trade-offs.
