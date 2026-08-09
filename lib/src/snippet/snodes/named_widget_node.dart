import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

import '../pnodes/string_pnode.dart' show StringPNode;

part 'named_widget_node.mapper.dart';

/// This snode is useful when a normal TRANSIENT widget has to
/// be rendered inside one of our mappable snode.
@MappableClass()
class NamedWidgetNode extends SNode with NamedWidgetNodeMappable {
  String? widgetName;

  NamedWidgetNode({super.name, this.widgetName});

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    StringPNode(
      snode: this,
      name: 'widgetName',
      nameOnSeparateLine: true,
      expands: false,
      numLines: 1,
      stringValue: widgetName,
      onStringChange: (newValue) {
        refreshWithUpdate(context, () => widgetName = newValue ?? '');
      },
      calloutButtonSize: const Size(280, 70),
      calloutWidth: 300,
    ),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode); // propagating parents down from root
    WidgetBuilder? namedWidgetBuilder = fsdui.namedWidgets[widgetName];
    return namedWidgetBuilder != null
    ? namedWidgetBuilder(context) : Icon(Icons.warning, color: Colors.red, size: 96,);
  }

  @override
  String toString() => FLUTTER_TYPE;

  @override
  Widget? widgetLogo() => Icon(
    Icons.space_dashboard_outlined,
    color: fsdui.selectedNode == this ? Colors.black : Colors.grey,
  );

  static const String FLUTTER_TYPE = "NamedWidget";
}
