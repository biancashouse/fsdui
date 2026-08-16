// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:responsive_flex_list/responsive_flex_list.dart';

import '../pnodes/bool_pnode.dart' show BoolPNode;
import '../pnodes/decimal_pnode.dart' show DecimalPNode;
import '../pnodes/edgeinsets_pnode.dart' show EdgeInsetsPNode;
import '../pnodes/enum_pnode.dart' show EnumPNode;
import '../pnodes/enums/enum_rfl_animation_type.dart';
import '../pnodes/fyi_pnodes.dart' show FlutterDocPNode;
import '../pnodes/int_pnode.dart' show IntPNode;

part 'responsive_flex_list_node.mapper.dart';

@MappableClass()
class ResponsiveFlexListNode extends SNode
    with MC, ResponsiveFlexListNodeMappable {
  @override
  List<SNode> children;

  EdgeInsets? padding;

  // Fixed column count. When null, the number of columns is derived
  // automatically from the available width via ResponsiveFlexList's
  // built-in breakpoints.
  int? crossAxisCount;
  int? minCrossAxisCount;
  int? maxCrossAxisCount;

  double? mainAxisSpacing;
  double? crossAxisSpacing;
  double? childAspectRatio;

  bool? shrinkWrap;
  bool? reverse;

  // Whether all items in a row match the height of the tallest item.
  // Relatively expensive - avoid enabling unless needed.
  bool? useIntrinsicHeight;

  // Distributes items sequentially across columns (1→2→3→1→2→3...).
  // Mutually exclusive with childAspectRatio (asserts if both are set).
  bool? roundRobinLayout;

  RFLAnimationTypeEnumModel? animationType;
  double? animationDurationMs;
  double? staggerDelayMs;

  ResponsiveFlexListNode({
    super.name,
    this.padding,
    this.crossAxisCount,
    this.minCrossAxisCount,
    this.maxCrossAxisCount,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.childAspectRatio,
    this.shrinkWrap,
    this.reverse,
    this.useIntrinsicHeight,
    this.roundRobinLayout,
    this.animationType,
    this.animationDurationMs,
    this.staggerDelayMs,
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    EdgeInsetsPNode(
      snode: this,
      name: 'padding',
      ei: padding,
      onEIChangedF: (newEI) => refreshWithUpdate(context, () => padding = newEI),
    ),
    IntPNode(
      snode: this,
      name: 'crossAxisCount',
      intValue: crossAxisCount,
      onIntChange: (newValue) =>
          refreshWithUpdate(context, () => crossAxisCount = newValue),
      calloutButtonSize: const Size(130, 20),
    ),
    IntPNode(
      snode: this,
      name: 'minCrossAxisCount',
      intValue: minCrossAxisCount,
      onIntChange: (newValue) =>
          refreshWithUpdate(context, () => minCrossAxisCount = newValue),
      calloutButtonSize: const Size(130, 20),
    ),
    IntPNode(
      snode: this,
      name: 'maxCrossAxisCount',
      intValue: maxCrossAxisCount,
      onIntChange: (newValue) =>
          refreshWithUpdate(context, () => maxCrossAxisCount = newValue),
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
    DecimalPNode(
      snode: this,
      name: 'childAspectRatio',
      decimalValue: childAspectRatio,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => childAspectRatio = newValue),
    ),
    BoolPNode(
      snode: this,
      name: 'shrinkWrap',
      boolValue: shrinkWrap,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => shrinkWrap = newValue),
    ),
    BoolPNode(
      snode: this,
      name: 'reverse',
      boolValue: reverse,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => reverse = newValue),
    ),
    BoolPNode(
      snode: this,
      name: 'useIntrinsicHeight',
      boolValue: useIntrinsicHeight,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => useIntrinsicHeight = newValue),
    ),
    BoolPNode(
      snode: this,
      name: 'roundRobinLayout',
      boolValue: roundRobinLayout,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => roundRobinLayout = newValue),
    ),
    EnumPNode<RFLAnimationTypeEnumModel?>(
      snode: this,
      name: 'animationType',
      valueIndex: animationType?.index,
      onIndexChange: (newValue) => refreshWithUpdate(
        context,
        () => animationType = RFLAnimationTypeEnumModel.of(newValue),
      ),
    ),
    DecimalPNode(
      snode: this,
      name: 'animationDurationMs',
      decimalValue: animationDurationMs,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => animationDurationMs = newValue),
    ),
    DecimalPNode(
      snode: this,
      name: 'staggerDelayMs',
      decimalValue: staggerDelayMs,
      onDoubleChange: (newValue) =>
          refreshWithUpdate(context, () => staggerDelayMs = newValue),
    ),
    FlutterDocPNode(
      buttonLabel: 'ResponsiveFlexList',
      webLink: 'https://pub.dev/packages/responsive_flex_list',
      snode: this,
      name: 'fyi',
    ),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode);
      return ResponsiveFlexList.withSeparators(
        padding: padding,
        gridDelegate: ResponsiveFlexGridDelegate(
          crossAxisCount: crossAxisCount,
          minCrossAxisCount: minCrossAxisCount,
          maxCrossAxisCount: maxCrossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        shrinkWrap: shrinkWrap ?? false,
        reverse: reverse ?? false,
        useIntrinsicHeight: useIntrinsicHeight ?? false,
        roundRobinLayout: roundRobinLayout ?? false,
        animationType: animationType?.flutterValue ?? kDefaultAnimationType,
        animationDuration: animationDurationMs != null
            ? Duration(milliseconds: animationDurationMs!.round())
            : null,
        staggerDelay: staggerDelayMs != null
            ? Duration(milliseconds: staggerDelayMs!.round())
            : kDefaultStaggerDelay,
        mainAxisSeparatorMode: MainAxisSeparatorMode.itemWidth,
        mainAxisSeparator: (rowIndex, totalRows) =>
            Divider(thickness: 2, height: 2),
        crossAxisSeparator: (columnIndex, totalColumns) =>
            VerticalDivider(thickness: 2, width: 2),
        itemCount: children.length,
        itemBuilder: (context, index) {
          if (children.isEmpty) return const Offstage();
          return children[index].build(context, this);
        },
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
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "ResponsiveFlexList";
}
