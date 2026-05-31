import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/snodes/flex_mixin.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_cross_axis_alignment.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_main_axis_alignment.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_main_axis_size.dart';

import '../pnodes/fyi_pnodes.dart';

part 'flex_node.mapper.dart';

@MappableClass()
class FlexNode extends SNode with MC, FlexMixin, FlexNodeMappable {
  @override
  AxisEnum direction;
  @override
  MainAxisAlignmentEnumModel? mainAxisAlignment;
  @override
  MainAxisSizeEnum? mainAxisSize;
  @override
  CrossAxisAlignmentEnumModel? crossAxisAlignment;
  @override
  List<SNode> children;

  FlexNode({
    super.name,
    required this.direction,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.crossAxisAlignment,
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    ...flexPropertyNodes(context, parentSNode),
    FlutterDocPNode(
      buttonLabel: 'Flex',
      webLink: 'https://api.flutter.dev/flutter/widgets/Flex-class.html',
      snode: this,
      name: 'fyi',
    ),
  ];

  @override
  List<Widget> menuAnchorWidgets_WrapWith(
    BuildContext context,
    NodeAction action,
    bool? skipHeading,
  ) {
    return [
      ...super.menuAnchorWidgets_Heading(context, action),
      menuItemButton(context, "Expanded", ExpandedNode, action),
      menuItemButton(context, "Flexible", FlexibleNode, action),
      ...super.menuAnchorWidgets_WrapWith(context, action, true),
    ];
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "Flex";
}
