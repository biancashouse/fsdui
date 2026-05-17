// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:fsdui/src/snippet/snodes/tabdata_node.dart';

part 'dynamic_tabbar_node.mapper.dart';

@MappableClass()
class DynamicTabBarNode extends MC with DynamicTabBarNodeMappable {
  DynamicTabBarNode({
    super.name,
    // children are TabDataNodes
    required super.children,
  });

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    FlutterDocPNode(
      buttonLabel: 'DynamicTabBar',
      webLink: 'https://pub.dev/packages/dynamic_tabbar',
      snode: this,
      name: 'fyi',
    ),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);

    List<TabData> tabData = children.indexed.map((record) {
      int index = record.$1;
      TabDataNode tabDataNode = (record.$2) as TabDataNode;
      return TabData(
        index: index,
        title: Tab(text:tabDataNode.title),
        content: tabDataNode.child?.build(context, this)??Placeholder(),
      );
    }).toList();

    return DynamicTabBarWidget(
      key: createNodeWidgetGK(),
      dynamicTabs: tabData,
      // optional properties :-----------------------------
      // isScrollable: isScrollable,
      onTabControllerUpdated: (controller) {
        debugPrint("onTabControllerUpdated");
      },
      onTabChanged: (index) {
        debugPrint("Tab changed: $index");
      },
      // onAddTabMoveTo: MoveToTab.last,
      // // onAddTabMoveToIndex: tabs.length - 1, // Random().nextInt(tabs.length);
      // // backIcon: Icon(Icons.keyboard_double_arrow_left),
      // // nextIcon: Icon(Icons.keyboard_double_arrow_right),
      // showBackIcon: showBackIcon,
      // showNextIcon: showNextIcon,
      // leading: leading,
      // trailing: trailing,
    );
  }

  @override
  List<Type> replaceWithOnly() => [DynamicTabBarNode];

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "TabBar";
}
