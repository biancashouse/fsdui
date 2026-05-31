import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

part 'named_multi_child_node.mapper.dart';

@MappableClass()
class NamedMC extends SNode with MC, NamedMCMappable {
  @override
  List<SNode> children;

  String propertyName; // Widget property name, such as actions
  NamedMC({
    super.name,
    required this.propertyName,
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => const [];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) => fsdui.coloredText('GenericMultiChildNode - Use toWidgetProperty() instead of toWidget() !', fontSize: 36);

  List<Widget>? toWidgetProperty(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode);
    //ScrollControllerName? scName = EditablePage.name(context);
    //possiblyHighlightSelectedNode(scName);
      List<Widget> childWidgets = children.map((node) => node.build(context, this)).toList();
      return childWidgets;
    } catch (e) {
      fsdui.logger.e('', error:e);
      return [];
    }
  }

  @override
  bool canWrap() => false;

  @override
  bool canReplace() => false;

  @override
  bool canAddASibling() => false;

  @override
  String toString() => propertyName;

  static const String FLUTTER_TYPE = "MultiChildProperty"; //should be visible in the tree, but not rendered as a widget in the generated ui
}
