// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/pnodes/string_pnode.dart';

part 'tabdata_node.mapper.dart';

@MappableClass()
class TabDataNode extends SC with TabDataNodeMappable {
  String title;

  TabDataNode({this.title = 'unnamed tab', super.child});

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) {
    // fco.logger.i('textStyleName is "$textStyleName"');
    return [
      StringPNode(
        snode: this,
        name: 'title',
        nameOnSeparateLine: true,
        expands: true,
        numLines: 2,
        stringValue: title,
        onStringChange: (newValue) {
          refreshWithUpdate(context, () => title = newValue ?? 'unnamed tab');
        },
        calloutButtonSize: const Size(280, 70),
        calloutWidth: 300,
      ),
      FlutterDocPNode(
        buttonLabel: 'DynamicTabBar',
        webLink: 'https://pub.dev/packages/dynamic_tabbar',
        snode: this,
        name: 'fyi',
      ),
    ];
  }

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);

    // just return the content widget:
    // DynamicTabBarNode picks up the title directly
    return child?.build(context, this) ?? Placeholder();
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "Tab Data";
}
