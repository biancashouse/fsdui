# NamedWidgetNode overrode the wrong build method

**File(s):** `lib/src/snippet/snodes/named_widget_node.dart`

## Problem

Found while fixing the `build_runner` failure on the same new class (see
[named-widget-node-missing-mappable-annotation.md](./named-widget-node-missing-mappable-annotation.md)):
`NamedWidgetNode` rendered its content correctly, but if it were ever used
as a snippet root it would silently skip the editor's usual
triangle/banner chrome that every other snippet-root node gets.

## Root Cause

`NamedWidgetNode` overrode `build(BuildContext, SNode?)` directly:

```dart
@override
Widget build(BuildContext context, SNode? parentNode) {
  setParent(parentNode);
  return fsdui.namedWidgets[widgetName] ?? Icon(Icons.warning, ...);
}
```

But `build()` is not the method SNode subclasses are meant to override —
it's the base class's dispatcher, which decides whether to wrap the node's
actual content with snippet-root/editing chrome before rendering it:

```dart
// SNode base class:
Widget build(BuildContext context, SNode? parentNode) => isASnippetRoot
    ? _wrapWithTriangleAndBanner(buildFlutterWidget(context, parentNode))
    : this is ListViewNode
    ? _wrapWithTriangle(buildFlutterWidget(context, parentNode))
    : buildFlutterWidget(context, parentNode);

Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
  return Placeholder(); // subclasses override *this*
}
```

By overriding `build()` instead of `buildFlutterWidget()`, `NamedWidgetNode`
replaced the dispatcher itself rather than just supplying its content —
so `isASnippetRoot` wrapping (and the `ListViewNode` triangle case) would
never run for it.

## Strategy

Renamed the override from `build` to `buildFlutterWidget`, matching every
other SNode subclass in the codebase, and kept `@override`. No other change
was needed — the base `build()` dispatcher now correctly wraps
`NamedWidgetNode`'s content when appropriate.
