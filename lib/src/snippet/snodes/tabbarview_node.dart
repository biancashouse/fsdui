// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/pnodes/string_pnode.dart';

part 'tabbarview_node.mapper.dart';

@MappableClass()
class TabBarViewNode extends MC with TabBarViewNodeMappable {
  String tabBarName;

  TabBarViewNode({super.name, required this.tabBarName, required super.children});

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    FlutterDocPNode(
      buttonLabel: 'TabBarView',
      webLink: 'https://api.flutter.dev/flutter/material/TabBarView-class.html',
      snode: this,
      name: 'fyi',
    ),
    StringPNode(
      snode: this,
      name: 'TabBar name',
      stringValue: tabBarName,
      skipHelperText: true,
      onStringChange: (newValue) =>
          refreshWithUpdate(context, () => tabBarName = newValue!),
      calloutButtonSize: const Size(280, 70),
      calloutWidth: 400,
      numLines: 1,
    ),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    try {
      setParent(parentNode);
      //ScrollControllerName? scName = EditablePage.name(context);
      //possiblyHighlightSelectedNode(scName);
      final snippetName = rootNodeOfSnippet()?.name;
      final spState = snippetName != null ? fsdui.snippetBuilderStates[snippetName] : null;
      TabBarNode? tabBarNode = spState?.tabBars[tabBarName];
      if (tabBarNode == null) {
        return Placeholder();
      }
      int numTabNodes = tabBarNode.tabC?.length ?? 0;
      List<Widget> childWidgets = children
          // .map((node) => TabBarViewPage(child: node.toWidget(context, this)))
          .map((node) => node.build(context, this))
          .toList();
      try {
        if (numTabNodes != children.length) {
          throw Exception(
            'TabBar and TabBarView do not have matching number of children!',
          );
        } else {
          return TabBarView(
            key: createNodeWidgetGK(),
            controller: tabBarNode.tabC,
            children: childWidgets,
          );
        }
      } catch (e) {
        fsdui.logger.i('TabBarViewNode.toWidget() failed!');
        return Error(
          key: createNodeWidgetGK(),
          FLUTTER_TYPE,
          errorMsg: e.toString(),
        );
      }
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
  List<Type> replaceWithOnly() => [TabBarViewNode];

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "TabBarView";
}

// class TabBarViewParent extends StatefulWidget {
//   final TabBarView child;
//
//   const TabBarViewParent({required this.child, super.key});
//
//   static TabBarViewParentState? of(BuildContext? context) {
//     if (context == null) return null;
//
//     if (!context.mounted) {
//       fco.logger.i('context not mounted!');
//     }
//    return context.findAncestorStateOfType<TabBarViewParentState>();
//   }
//   @override
//   State<TabBarViewParent> createState() => TabBarViewParentState();
// }
//
// class TabBarViewParentState extends State<TabBarViewParent>
//     with AutomaticKeepAliveClientMixin<TabBarViewParent> {
//   @override
//   bool get wantKeepAlive => false;
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return widget.child;
//   }
// }
