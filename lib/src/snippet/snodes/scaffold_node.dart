// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/bool_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/color_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

part 'scaffold_node.mapper.dart';

@MappableClass()
class ScaffoldNode extends CL with ScaffoldNodeMappable {
  ColorModel? bgColor;
  @MappableField(hook: AppBarHook())
  NamedPS appBar;
  NamedSC body;
  bool? canShowEditorLoginBtn;

  ScaffoldNode({
    super.name,
    this.bgColor,
    required this.appBar,
    required this.body,
    this.canShowEditorLoginBtn,
  });

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) {
    return [
      ColorPNode(
        snode: this,
        name: 'background color',
        color: bgColor,
        onColorChange: (newValue) =>
            refreshWithUpdate(context, () => bgColor = newValue),
        calloutButtonSize: const Size(200, 20),
      ),
      // BoolPNode(
      //   snode: this,
      //   name: 'use TabBar',
      //   boolValue: useTabBar,
      //   onBoolChange: (newValue) =>
      //       refreshWithUpdate(context, () => useTabBar = newValue),
      // ),
      FlutterDocPNode(
        buttonLabel: 'Scaffold',
        webLink: 'https://api.flutter.dev/flutter/material/Scaffold-class.html',
        snode: this,
        name: 'fyi',
      ),
    ];
  }

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);
    // if (useTabBar ?? false) {
    //   return ScaffoldWithTabBarWidget(node: this);
    // }
    var appBarProp = appBar.child != null
        ? appBar.buildPreferredSizeFlutterWidget(context, this)
        : null;
    return Scaffold(
      key: createNodeWidgetGK(),
      backgroundColor: bgColor?.flutterValue,
      appBar: appBarProp,
      body: body.child != null ? body.build(context, this) : null,
    );
  }

  @override
  List<Widget> menuAnchorWidgets_Append(
    BuildContext context,
    NodeAction action,
    bool? skipHeading,
  ) {
    return [
      ...super.menuAnchorWidgets_Heading(context, action),
      menuItemButton(context, "AppBar", AppBarNode, action),
    ];
  }

  @override
  List<Type> replaceWithRecommendations() => [ScaffoldNode];

  @override
  SNode removeFromParent() {
    var parent = getParent() as SNode?;

    if (parent == null) {
      return this;
    }

    if (parent is SC && parent.child == this) {
      parent.child = body.child;
      body.child?.setParent(parent);
      setParent(null);
      return parent;
    } else if (parent is MC && parent.children.contains(this)) {
      int index = parent.children.indexOf(this);
      parent.children.remove(this);
      if (parent.children.isNotEmpty && body.child != null) {
        parent.children.insert(index, body.child!);
        body.child?.setParent(parent);
      }
      setParent(null);
      return parent;
    } else {
      return this;
    }
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "Scaffold";
}

class ScaffoldWithTabBarWidget extends StatefulWidget {
  final ScaffoldNode node;

  const ScaffoldWithTabBarWidget({required this.node, super.key});

  static ScaffoldWithTabBarWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<ScaffoldWithTabBarWidgetState>();

  @override
  State<ScaffoldWithTabBarWidget> createState() =>
      ScaffoldWithTabBarWidgetState();
}

class ScaffoldWithTabBarWidgetState extends State<ScaffoldWithTabBarWidget> {
  TabBarNode? get tabBarNode =>
      widget.node.findDescendant(TabBarNode) as TabBarNode?;

  TabBarViewNode? get tabBarViewNode =>
      widget.node.findDescendant(TabBarViewNode) as TabBarViewNode?;

  void _warnIfOutOfSync() {
    final tb = tabBarNode;
    final tbv = tabBarViewNode;
    if (tb != null && tbv != null && tb.children.length != tbv.children.length) {
      fsdui.logger.w(
        'ScaffoldWithTabBar: TabBarNode (${tb.children.length} tabs) '
        'and TabBarViewNode (${tbv.children.length} views) are out of sync!',
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _warnIfOutOfSync();
  }

  @override
  void didUpdateWidget(ScaffoldWithTabBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _warnIfOutOfSync();
  }

  @override
  Widget build(BuildContext context) {
    final appBarProp = widget.node.appBar.child != null
        ? widget.node.appBar.buildPreferredSizeFlutterWidget(context, widget.node)
        : null;
    return Scaffold(
      key: widget.node.createNodeWidgetGK(),
      backgroundColor: widget.node.bgColor?.flutterValue,
      appBar: appBarProp,
      body: widget.node.body.child != null
          ? widget.node.body.build(context, widget.node)
          : null,
    );
  }
}
