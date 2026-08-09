# `fsdui.logger` silently drops every log call, at any level

**File(s):** `lib/fsdui.dart`

## Problem
`fsdui.logger.w(...)`, `.i(...)`, `.e(...)` etc. never produce any console
output, in any app consuming this package, under any circumstances. This
cost a large amount of debugging time on an unrelated investigation (a
`TabBarView` rendering bug — see
[tabbarview-cross-tree-tabbarnode-lookup.md](./tabbarview-cross-tree-tabbarnode-lookup.md))
before being noticed: several rounds of `fsdui.logger.w('...')` calls added
purely as temporary diagnostic instrumentation produced zero console
output, which looked exactly like "this code path never runs" and led the
investigation astray for a long time. The code path *was* running; the
logger just never printed anything.

## Root Cause
```dart
class MyLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return false;
  }
}
```
`fsdui`'s internal `Logger` instance is constructed with `filter:
MyLogFilter()`, and `shouldLog` unconditionally returns `false` — every
single log call is filtered out before it ever reaches a printer,
regardless of level (`.i`, `.w`, `.e`, ...) or content. There's no dev/debug
mode check, no `kDebugMode` gate — it's just always off.

## Fix & Strategy
Not fixed — left as-is, since it's unclear whether this is intentional
(e.g. logging deliberately silenced for a production app, to be re-enabled
via some other mechanism not yet wired up) or simply dead/forgotten code.
Flagging here so it isn't mistaken for "this code never executes" again.

## Workarounds & Trade-offs
- For any temporary diagnostic logging in this codebase, use plain
  `print()` (or `debugPrint()`), not `fsdui.logger.*()` — `print()` bypasses
  this filter entirely and reliably reaches the browser/terminal console.
- If `fsdui.logger` output is ever actually needed (not just ad-hoc
  debugging), `MyLogFilter.shouldLog` will need a real implementation, e.g.
  gating on `kDebugMode` or a configurable log level, instead of a hardcoded
  `false`.
