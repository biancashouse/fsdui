// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

part 'sliver_floating_header_node.mapper.dart';

@MappableClass()
class SliverFloatingHeaderNode extends SC with SliverFloatingHeaderNodeMappable {
  SliverFloatingHeaderNode({
    super.name,
    super.child,
  });

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    FlutterDocPNode(
        buttonLabel: 'SliverFloatingHeader',
        webLink: 'https://api.flutter.dev/flutter/widgets/SliverFloatingHeader-class.html',
        snode: this,
        name: 'fyi')
  ];

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "SliverFloatingHeader";

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
      setParent(parentNode);
      return SliverFloatingHeader(
            key: createNodeWidgetGK(),
            child: child?.build(context, this) ?? Error(
              key: createNodeWidgetGK(),
              "${toString()} $uid",
              color: Colors.red,
              size: 16,
              errorMsg:
              "Child is null !",
            )
          );
  }
}
