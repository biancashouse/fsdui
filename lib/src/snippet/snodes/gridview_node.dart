// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/pnodes/int_pnode.dart';


part 'gridview_node.mapper.dart';

@MappableClass()
class GridViewNode extends SNode with ScrollViewNode, BoxScrollViewNode, GridViewNodeMappable {
  @override
  AxisEnum scrollDirection;
  @override
  bool? shrinkWrap;
  @override
  EdgeInsets? padding;

  List<SNode> children;
  int? crossAxisCount;
  double? mainAxisSpacing;
  double? crossAxisSpacing;

  GridViewNode({
    super.name,
    this.scrollDirection = AxisEnum.vertical,
    this.shrinkWrap,
    this.padding,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.crossAxisCount,
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    ...svPropertyNodes(context, parentSNode),
    ...bsvPropertyNodes(context, parentSNode),

    IntPNode(
      snode: this,
      name: 'crossAxisCount',
      intValue: crossAxisCount,
      onIntChange: (newValue) =>
          refreshWithUpdate(context, () => crossAxisCount = newValue),
      calloutButtonSize: const Size(130, 20),
    ),
    DecimalPNode(
      snode: this,
      name: 'mainAxisSpacing',
      decimalValue: mainAxisSpacing,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => mainAxisSpacing = newValue),
    ),
    DecimalPNode(
      snode: this,
      name: 'crossAxisSpacing',
      decimalValue: crossAxisSpacing,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => crossAxisSpacing = newValue),
    ),
    FlutterDocPNode(
        buttonLabel: 'GridView',
        webLink: 'https://api.flutter.dev/flutter/widgets/GridView-class.html',
        snode: this,
        name: 'fyi'),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode);
      return LayoutBuilder(
        builder: (context, constraints) {
          bool constraintError = constraints.maxHeight == double.infinity;
          return constraintError
              ? Error(
            key: createNodeWidgetGK(),
            "${toString()} $uid",
            color: Colors.red,
            size: 16,
            errorMsg:
            "Parent ${toString()} has an infinite 'maxHeight'} Constraints Error!",
          )
              : GridView.count(
            controller: sc,
            scrollDirection: scrollDirection.flutterValue,
            shrinkWrap: shrinkWrap ?? false,
            padding: padding,
            crossAxisCount: crossAxisCount ?? 2,
            mainAxisSpacing: mainAxisSpacing??0.0,
            crossAxisSpacing: crossAxisSpacing??0.0,
            key: createNodeWidgetGK(),
            children: children
                .map(
                  (childNode) =>
                  childNode.build(context, this),
            )
                .toList(),
          );
        },
      );
    } catch (e) {
      return Error(
        key: createNodeWidgetGK(),
        toString(),
        color: Colors.red,
        size: 16,
        errorMsg: e.toString(),
      );
    }
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "GridView";
}
