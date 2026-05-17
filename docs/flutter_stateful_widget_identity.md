# Flutter StatefulWidget Identity and List Reordering

## The core problem

Flutter's element reconciliation algorithm matches widgets to existing elements
by **type and key**. When an element already exists at a position in the tree,
Flutter calls `Widget.canUpdate(oldWidget, newWidget)`:

```dart
static bool canUpdate(Widget oldWidget, Widget newWidget) {
  return oldWidget.runtimeType == newWidget.runtimeType
      && oldWidget.key == newWidget.key;
}
```

If this returns `true`, Flutter **reuses** the existing `State` object and calls
`didUpdateWidget` — it does **not** dispose and recreate the state. If it
returns `false`, Flutter disposes the old state and creates a fresh one.

The trap: **`null == null` is `true`**. Two widgets of the same type with no
explicit key always satisfy `canUpdate`, even if they logically represent
completely different data objects.

---

## How this bites you in a list

Consider a `SliverList` (or any `ListView` / `Column`) rendering nodes:

```
Position 0 → _MarkdownWidget(node: A)   ← State_A owns _controller_A
Position 1 → _MarkdownWidget(node: B)   ← State_B owns _controller_B
```

After a sibling reorder the list becomes:

```
Position 0 → _MarkdownWidget(node: B)
Position 1 → _MarkdownWidget(node: A)
```

Because both widgets have the same type and no key, Flutter does **not**
recreate the states. Instead:

- `State_A.didUpdateWidget(_MarkdownWidget(node: B))` is called at position 0.
  Now `widget.node = B` but `_controller = _controller_A` and
  `gk = A.nodeWidgetGK`. The state is serving the wrong node.
- `State_B.didUpdateWidget(_MarkdownWidget(node: A))` is called at position 1.
  Same problem in reverse.

Consequences:

| Problem | Symptom |
|---------|---------|
| `_controller` belongs to the old node | Edits go to the wrong `node.data` |
| `node.controller` on the new node is stale | "used after being disposed" when anything reads `node.controller` |
| `gk` (GlobalKey) belongs to the old node | `nodeWidgetGK.currentContext` points to the wrong widget; border-rect overlays appear in the wrong place |
| `dispose()` guards based on `node.controller` fire for the wrong node | Old controller leaked or double-disposed |

---

## The fix: key StatefulWidgets by their data identity

Add `key: ObjectKey(dataObject)` (or `key: ValueKey(dataObject.uid)`) wherever
a `StatefulWidget` is tied to a specific data object and lives inside a list
that can reorder:

```dart
// Before — broken:
return _MarkdownWidget(node: this);

// After — correct:
return _MarkdownWidget(key: ObjectKey(this), node: this);
```

And accept the key in the constructor:

```dart
const _MarkdownWidget({super.key, required this.node});
```

Now `Widget.canUpdate` compares keys. `ObjectKey(A) != ObjectKey(B)`, so
Flutter **disposes** the state for A and **creates** a fresh state for B.
`initState` runs with the correct node. `didUpdateWidget` is never called
with a mismatched node.

---

## The rule of thumb

> **Any `StatefulWidget` whose `State` is initialised from a specific data
> object must carry a key derived from that object's identity whenever it can
> appear in a list or any position that could be filled by a different object.**

Checklist before writing a `StatefulWidget` that reads from a passed-in object:

1. **Does `initState` read from `widget.someObject`?** If yes, you have
   identity-bound state.

2. **Could this widget ever appear inside a `ListView`, `Column`, `SliverList`,
   or any parent that renders multiple siblings of the same type?** If yes, the
   list might reuse this state for a different object.

3. **Does `didUpdateWidget` fully re-initialise every piece of state that
   `initState` set up?** Controllers, keys, listeners, animation objects — all
   of them. If not (and it's usually impractical to do so), use a key instead.

4. **Are you storing a back-reference on the data object** (e.g.
   `node.controller = _controller`)? Back-references become stale if the state
   is reused; a key prevents that entirely.

If the answer to 1 + 2 is "yes" and 3 is "no", add a key.

---

## Choosing the right key

| Key type | When to use |
|----------|-------------|
| `ObjectKey(obj)` | Object identity matters; no stable string/int ID available |
| `ValueKey(obj.uid)` | Object has a stable unique string or int ID |
| `GlobalKey` | You also need to access the state or `RenderObject` from outside — use sparingly, it carries a global lookup cost |

In this codebase, `SNode` objects have a `uid` field, so both work. Prefer
`ValueKey(node.uid)` for SNodes because it survives object replacement (e.g.
after an undo that recreates the node object) as long as the uid is preserved.

---

## Common false sense of safety

### "I handle it in `didUpdateWidget`"

Partially true, but `didUpdateWidget` is easy to get wrong:

- You must re-initialise **every** piece of identity-bound state (controllers,
  animation controllers, focus nodes, GlobalKeys, back-references on the data
  object).
- You must decide what to do with the **old** resources (dispose? transfer?).
- If a future developer adds new state in `initState` and forgets
  `didUpdateWidget`, the bug silently returns.

A key eliminates all of this: `initState` and `dispose` are the only lifecycle
methods you need to reason about, and they always fire with a consistent node.

### "The list doesn't reorder today"

Lists that today only append/remove can be sorted or reordered tomorrow. Keys
cost almost nothing and make the widget robust to future changes.

### "The controller is still alive, so the old `node.controller` reference is fine"

It seems fine until:

- Another frame disposes the state (widget scrolled off-screen in a lazy list,
  overlay dismissed, screen popped).
- The controller is now disposed but `node.controller` still points to it.
- Anything that reads `node.controller` crashes.

Back-references on data objects are safe **only** if the data object's lifetime
exactly matches the widget's lifetime. In a dynamic editor like this one, that
assumption almost never holds.

---

## Concrete patterns used in this codebase

### Pattern: back-reference on SNode

```dart
// In SNode subclass:
late MarkdownEditingController controller;

// In _MarkdownWidgetState.initState:
_controller = MarkdownEditingController(text: widget.node.data ?? '');
widget.node.controller = _controller;

// In _MarkdownWidgetState.dispose:
// Guard: only dispose if we're still the owner.
if (widget.node.controller != _controller) _controller.dispose();
```

The dispose guard is belt-and-suspenders. The **primary** protection is the key:

```dart
return _MarkdownWidget(key: ObjectKey(this), node: this);
```

With the key in place, `initState`/`dispose` always run with the correct node
and the guard is rarely needed.

### Pattern: stable GlobalKey on SNode (`nodeWidgetGK`)

`SNode.createNodeWidgetGK()` returns the same `GlobalKey` for a given node
instance across all builds. Because `_MarkdownWidgetState` stores
`gk = widget.node.createNodeWidgetGK()` in `initState` and uses it as the key
for `StringOrNumberEditor`, the GlobalKey is always the correct one for the
node — **provided** `initState` is called with the right node. Again, the
`ObjectKey` on `_MarkdownWidget` is what guarantees that.

---

## Quick reference

```
StatefulWidget reads from widget.X in initState
         │
         ▼
Could appear in a list alongside other widgets of the same type?
         │
        YES
         │
         ▼
Add key: ObjectKey(X)  or  key: ValueKey(X.uid)
to the widget construction site.
         │
         ▼
Does initState store a back-reference on X (e.g. X.controller = _controller)?
         │
        YES
         │
         ▼
Guard dispose():
  if (widget.X.controller == _controller) → we still own it → don't dispose
  if (widget.X.controller != _controller) → new owner took over → dispose old
```
