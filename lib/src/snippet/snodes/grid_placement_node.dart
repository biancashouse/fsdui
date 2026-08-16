import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fsdui/fsdui.dart';

import '../pnodes/fyi_pnodes.dart';
import '../pnodes/int_pnode.dart';

part 'grid_placement_node.mapper.dart';

@MappableClass()
class GridPlacementNode extends SNode with SC, GridPlacementNodeMappable {
  @override
  SNode? child;

  @override
  bool canAppendAChild() => child == null;

  // If null, the child is auto-placed on this axis.
  int? columnStart;
  int? columnSpan;
  int? rowStart;
  int? rowSpan;

  GridPlacementNode({
    super.name,
    this.columnStart,
    this.columnSpan,
    this.rowStart,
    this.rowSpan,
    this.child,
  });

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    IntPNode(
      snode: this,
      name: 'columnStart',
      intValue: columnStart,
      onIntChange: (newValue) =>
          refreshWithUpdate(context, () => columnStart = newValue),
      calloutButtonSize: const Size(130, 20),
    ),
    IntPNode(
      snode: this,
      name: 'columnSpan',
      intValue: columnSpan,
      onIntChange: (newValue) =>
          refreshWithUpdate(context, () => columnSpan = newValue),
      calloutButtonSize: const Size(130, 20),
    ),
    IntPNode(
      snode: this,
      name: 'rowStart',
      intValue: rowStart,
      onIntChange: (newValue) =>
          refreshWithUpdate(context, () => rowStart = newValue),
      calloutButtonSize: const Size(130, 20),
    ),
    IntPNode(
      snode: this,
      name: 'rowSpan',
      intValue: rowSpan,
      onIntChange: (newValue) =>
          refreshWithUpdate(context, () => rowSpan = newValue),
      calloutButtonSize: const Size(130, 20),
    ),
    FlutterDocPNode(
      buttonLabel: 'GridPlacement',
      webLink: 'https://pub.dev/packages/flutter_layout_grid',
      snode: this,
      name: 'fyi',
    ),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);
    try {
      return GridPlacement(
        key: createNodeWidgetGK(),
        columnStart: columnStart,
        columnSpan: columnSpan ?? 1,
        rowStart: rowStart,
        rowSpan: rowSpan ?? 1,
        child: Tooltip(
          message: "GridPlacement(missing child!)",
          child: child?.build(context, this) ??
              const Icon(Icons.warning, color: Colors.deepOrange),
        ),
      );
    } catch (e) {
      return Error(
        key: createNodeWidgetGK(),
        FLUTTER_TYPE,
        color: Colors.red,
        size: 16,
        errorMsg: e.toString(),
      );
    }
  }

  @override
  List<Type> replaceWithRecommendations() => [GridPlacementNode];

  List<Widget> menuAnchorWidgets_WrapWith(
    BuildContext context,
    NodeAction action,
    bool? skipHeading,
  ) {
    return [
      if (getParent() is! CSSGridNode)
        ...super.menuAnchorWidgets_Heading(context, action),
      if (getParent() is! CSSGridNode)
        menuItemButton(context, "CSSGrid", CSSGridNode, action),
    ];
  }

  @override
  List<Type> wrapCandidates() => [CSSGridNode];

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "GridPlacement";
}
