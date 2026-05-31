import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

part 'constrainedbox_node.mapper.dart';

@MappableClass()
class ConstrainedBoxNode extends SNode with SC, ConstrainedBoxNodeMappable {
  @override
  SNode? child;

  @override
  bool canAppendAChild() => child == null;
  double? minWidth;
  double? minHeight;
  double? maxWidth;
  double? maxHeight;

  ConstrainedBoxNode({
    super.name,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.child,
  });

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
      DecimalPNode(
        snode: this,
        name: 'minWidth',
        decimalValue: minWidth,
        onDoubleChange: (newValue) =>
            refreshWithUpdate(context, () => minWidth = newValue),
      ),
      DecimalPNode(
        snode: this,
        name: 'minHeight',
        decimalValue: minHeight,
        onDoubleChange: (newValue) =>
            refreshWithUpdate(context, () => minHeight = newValue),
      ),
      DecimalPNode(
        snode: this,
        name: 'maxWidth',
        decimalValue: maxWidth,
        onDoubleChange: (newValue) =>
            refreshWithUpdate(context, () => maxWidth = newValue),
      ),
      DecimalPNode(
        snode: this,
        name: 'maxHeight',
        decimalValue: maxHeight,
        onDoubleChange: (newValue) =>
            refreshWithUpdate(context, () => maxHeight = newValue),
      ),
    FlutterDocPNode(
      buttonLabel: 'ConstrainedBox',
      webLink:
          'https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html',
      snode: this,
      name: 'fyi',
    ),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);
    //ScrollControllerName? scName = EditablePage.name(context);
    //possiblyHighlightSelectedNode(scName);
    // var targetGK = nodeWidgetGK;

    try {
      return ConstrainedBox(
        // key: targetGK,
        key: createNodeWidgetGK(),
        constraints: BoxConstraints(
          minWidth: minWidth != null ? minWidth! : 0.0,
          minHeight: minHeight != null ? minHeight! : 0.0,
          maxWidth: maxWidth != null ? maxWidth! : double.infinity,
          maxHeight: maxHeight != null ? maxHeight! : double.infinity,
        ),
        child: child?.build(context, this),
      );
    } catch (e) {
      print(e);
      return Placeholder(key: createNodeWidgetGK());
    }
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "ConstrainedBox";
}
