# StringListPNode rebuilt the whole snippet tree on every keystroke

**File(s):** `lib/src/snippet/pnodes/editors/property_button_string_list.dart`

## Problem

Typing into one of `StringListPNode`'s row text fields caused a visible
full refresh/flicker on every character typed, instead of updating smoothly.

## Root Cause

Each row's `TextField.onChanged` called `commit()` directly:

```dart
onChangedF: (v) {
  entry.value = v;
  commit(); // <- fires on every keystroke
},
```

`commit()` propagates the whole list up through `StringListPNode`'s
`onListChange`, which callers wire to `refreshWithUpdate(context, ...)` —
this dispatches `fsdui.capiBloc.add(ChangedSnippet())`, which rebuilds the
entire snippet tree. So every character typed triggered a full snippet
rebuild, not just a local widget update.

This is the same class of bug the codebase's other text-editing PNodes
(e.g. `StringPNode`, via `PropertyButton<T>`) deliberately avoid — those
only propagate a change on `onEditingComplete`/submit, not on every
`onChanged` callback.

## Strategy

Split the per-row callback into two distinct paths:

- `onLocalChangeF` — updates the in-memory row entry only, called on every
  keystroke, with **no** propagation to the node.
- `onCommitF` — propagates the full list up to the node (and thus triggers
  the snippet-tree refresh), called only on:
  - losing focus (via a `FocusNode` listener),
  - pressing Enter (`onSubmitted`),
  - add/remove/reorder (discrete structural actions, which should commit
    immediately since there's no "typing" to debounce), and
  - the "Done" button (which also calls `commit()` first, in case the field
    never lost focus before the tap was handled).
