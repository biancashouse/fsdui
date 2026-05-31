import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/enum_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_cross_axis_alignment.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_main_axis_alignment.dart';
import 'package:fsdui/src/snippet/pnodes/enums/enum_main_axis_size.dart';

mixin FlexMixin on SNode {
  abstract AxisEnum direction;
  abstract MainAxisAlignmentEnumModel? mainAxisAlignment;
  abstract MainAxisSizeEnum? mainAxisSize;
  abstract CrossAxisAlignmentEnumModel? crossAxisAlignment;
  abstract List<SNode> children;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? wrapInExpanded;

  List<PNode> flexPropertyNodes(BuildContext context, SNode? parentSNode) => [
    EnumPNode<AxisEnum?>(
      snode: this,
      name: 'direction',
      valueIndex: direction.index,
      onIndexChange: (newValue) => refreshWithUpdate(
        context,
        () => direction = AxisEnum.of(newValue) ?? AxisEnum.vertical,
      ),
    ),
    EnumPNode<MainAxisAlignmentEnumModel?>(
      snode: this,
      name: 'mainAxisAlignment',
      valueIndex: mainAxisAlignment?.index,
      onIndexChange: (newValue) => refreshWithUpdate(
        context,
        () => mainAxisAlignment = MainAxisAlignmentEnumModel.of(newValue),
      ),
    ),
    EnumPNode<MainAxisSizeEnum?>(
      snode: this,
      name: 'mainAxisSize',
      valueIndex: mainAxisSize?.index,
      onIndexChange: (newValue) => refreshWithUpdate(
        context,
        () => mainAxisSize = MainAxisSizeEnum.of(newValue),
      ),
    ),
    EnumPNode<CrossAxisAlignmentEnumModel?>(
      snode: this,
      name: 'crossAxisAlignment',
      valueIndex: crossAxisAlignment?.index,
      onIndexChange: (newValue) => refreshWithUpdate(
        context,
        () => crossAxisAlignment = CrossAxisAlignmentEnumModel.of(newValue),
      ),
    ),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode);

      List<Widget> flexChildWidgets = children
          .map((childNode) => childNode.build(context, this))
          .toList();

      var flex = Flex(
        direction: this is RowNode ? Axis.horizontal : Axis.vertical,
        key: createNodeWidgetGK(),
        mainAxisAlignment:
            mainAxisAlignment?.flutterValue ?? MainAxisAlignment.start,
        mainAxisSize: mainAxisSize?.flutterValue ?? MainAxisSize.min,
        crossAxisAlignment:
            crossAxisAlignment?.flutterValue ?? CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: flexChildWidgets,
      );

      return false && parentNode is FlexNode
          ? Expanded(child: flex)
          : LayoutBuilder(
              builder: (context, constraints) {
                bool rowConstraintError =
                    (this is RowNode &&
                    constraints.maxWidth == double.infinity);
                bool columnConstraintError =
                    (this is ColumnNode &&
                    constraints.maxHeight == double.infinity);
                return rowConstraintError || columnConstraintError
                    ? Error(
                        key: createNodeWidgetGK(),
                        "${toString()} $uid",
                        color: Colors.red,
                        size: 16,
                        errorMsg:
                            "${toString()} Parent has an infinite ${this is RowNode ? 'maxWidth' : 'maxHeight'} Constraints Error!",
                      )
                    : flex;
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
}
