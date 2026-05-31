// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/snodes/flex_mixin.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_cross_axis_alignment.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_main_axis_alignment.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_main_axis_size.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

part 'column_node.mapper.dart';

@MappableClass()
class ColumnNode extends SNode with MC, FlexMixin, ColumnNodeMappable {
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

  ColumnNode({
    super.name,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.crossAxisAlignment,
    this.direction = AxisEnum.vertical,
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    ...flexPropertyNodes(context, parentSNode),
    FlutterDocPNode(
        buttonLabel: 'Column',
        webLink: 'https://api.flutter.dev/flutter/widgets/Column-class.html',
        snode: this,
        name: 'fyi'),
  ];

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "Column";
}
