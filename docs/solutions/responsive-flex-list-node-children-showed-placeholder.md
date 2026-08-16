# ResponsiveFlexListNode's children rendered as blank Placeholder boxes

**File(s):** `lib/src/snippet/snodes/responsive_flex_list_node.dart`

## Problem

`ResponsiveFlexListNode.children` (e.g. `TextNode`s) rendered as Flutter's
diagonal-cross `Placeholder()` box instead of their actual content — a
`TextNode` child showed no text at all.

Confirmed via a throwaway widget test: for 2 `TextNode` children, the tree
contained exactly 2 `Placeholder` widgets and 0 `Text` widgets.

## Root Cause

`buildFlutterWidget`'s `itemBuilder` called `item.buildFlutterWidget(context,
parentNode)` directly on each child, instead of `item.build(context, this)`:

```dart
itemBuilder: (context, index) {
  final item = children[index];
  final widget = item.buildFlutterWidget(context, parentNode); // wrong
  return widget;
},
```

`SNode.build()` is the dispatch entry point every other container node uses
(`node.build(context, this)`); it wraps snippet-root/`ListViewNode` chrome and
then calls `buildFlutterWidget()`. Most leaf nodes implement rendering by
overriding `buildFlutterWidget()`, but `TextNode` instead overrides `build()`
directly and builds its `Text` widget there — it never overrides
`buildFlutterWidget()`. Calling `item.buildFlutterWidget()` straight past
`build()` therefore hit `SNode`'s own base-class fallback:

```dart
Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
  return Placeholder();
}
```

...which is exactly the diagonal-cross box observed for every item.

## Fix & Strategy

Changed the item builder to call the node's actual entry point:

```dart
final widget = item.build(context, this);
```

This matches the pattern used by every other multi-child node in the package
(`WrapNode`, `CarouselViewNode`, `GridViewNode`, ...): always render children
via `.build(context, this)`, never `.buildFlutterWidget()` directly, since
not every `SNode` subtype overrides the latter.

## Workarounds & Trade-offs

None needed — this was a straight one-line fix once the dispatch mismatch was
identified. No trade-offs.
