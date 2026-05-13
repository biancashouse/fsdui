// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/color_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/pnodes/string_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/text_style_pnodes.dart';

part 'tabbar_node.mapper.dart';

@MappableClass()
class TabBarNode extends MC with TabBarNodeMappable {
  String tabBarName;
  ColorModel? bgColor;
  TextStyleProperties labelTSPropGroup;
  ColorModel? selectedLabelColor;
  ColorModel? unselectedLabelColor;
  ColorModel? indicatorColor;
  double? indicatorWeight;
  int? selection;

  TabBarNode({
    super.name,
    required this.tabBarName,
    this.bgColor,
    required this.labelTSPropGroup,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.selection,
    required super.children,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  // used when a TabBar and TabBarView are used in a snippet's Scaffold
  TabController? tabC;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<int> prevTabQ = [];

  @JsonKey(includeFromJson: false, includeToJson: false)
  final prevTabQSize = ValueNotifier<int>(0);

  @JsonKey(includeFromJson: false, includeToJson: false)
  // allow the listener to know when to skip adding index back onto Q after a back btn
  bool? backBtnPressed;

  @override
  TextStyleProperties? textStyleProperties() => labelTSPropGroup;

  @override
  void setTextStyleProperties(TextStyleProperties newProps) =>
      labelTSPropGroup = newProps;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) {
    var textStyleName = fsdui.findTextStyleName(
      fsdui.appInfo,
      labelTSPropGroup,
    );
    textStyleName = textStyleName != null ? ': $textStyleName' : '';
    return [
      StringPNode(
        snode: this,
        name: 'tabBarName',
        stringValue: tabBarName,
        skipHelperText: true,
        onStringChange: (newValue) =>
            refreshWithUpdate(context, () => tabBarName = newValue!),
        calloutButtonSize: const Size(280, 70),
        calloutWidth: 400,
        numLines: 1,
      ),
      PNode /*Group*/ (
        snode: this,
        name: 'colours',
        children: [
          ColorPNode(
            snode: this,
            name: 'b/g Color',
            color: bgColor,
            onColorChange: (newValue) =>
                refreshWithUpdate(context, () => bgColor = newValue),
            calloutButtonSize: const Size(160, 20),
          ),
          ColorPNode(
            snode: this,
            name: 'selected label Color',
            color: selectedLabelColor,
            onColorChange: (newValue) =>
                refreshWithUpdate(context, () => selectedLabelColor = newValue),
            calloutButtonSize: const Size(160, 20),
          ),
          ColorPNode(
            snode: this,
            name: 'unselected label Color',
            color: unselectedLabelColor,
            onColorChange: (newValue) => refreshWithUpdate(
              context,
              () => unselectedLabelColor = newValue,
            ),
            calloutButtonSize: const Size(180, 20),
          ),
        ],
      ),
      TextStyleWithoutColorPNode /*Group*/ (
        snode: this,
        name: 'labelStyle',
        textStyleProperties: labelTSPropGroup,
        onGroupChange: (newValue, refreshPTree) {
          refreshWithUpdate(context, () {
            labelTSPropGroup = newValue;
            if (refreshPTree) {
              forcePropertyTreeRefresh(context);
            }
          });
        },
      ),
      // TextStyleWithoutColorPNode /*Group*/ (
      //   snode: this,
      //   name: 'labelStyle',
      //   textStyleProperties: labelTSPropGroup,
      //   onGroupChange: (newValue, refreshPTree) {
      //     if (refreshPTree) {
      //       forcePropertyTreeRefresh(context);
      //     }
      //     refreshWithUpdate(context, () => labelTSPropGroup = newValue);
      //   },
      // ),
      // ColorPNode(
      //   snode: this,
      //   name: 'indicatorColor',
      //   colorValue: indicatorColorValue,
      //   onColorIntChange: (newValue) =>
      //       refreshWithUpdate(context,() => indicatorColorValue = newValue),
      //   calloutButtonSize: const Size(120, 20),
      // ),
      DecimalPNode(
        snode: this,
        name: 'indicatorWeight',
        decimalValue: indicatorWeight,
        onDoubleChange: (newValue) => refreshWithUpdate(context, () {
          if (newValue != indicatorWeight) indicatorWeight = newValue;
        }),
        calloutButtonSize: const Size(130, 20),
      ),
      FlutterDocPNode(
        buttonLabel: 'TabBar',
        webLink: 'https://api.flutter.dev/flutter/material/TabBar-class.html',
        snode: this,
        name: 'fyi',
      ),
    ];
  }

  void _tabListenerF() {
    if (!(tabC?.indexIsChanging ?? true)) {
      if (!(backBtnPressed ?? false)) {
        prevTabQ.add(selection ?? 0);
        selection = tabC?.index;
        prevTabQSize.value = prevTabQ.length;
        // fco.logger.i("tab pressed: ${tabC!.index}, Q: ${prevTabQ.toString()}");
      } else {
        selection = tabC?.index;
        backBtnPressed = false;
      }
    }
  }

  void resetTabQandC() {
    prevTabQ.clear();
    selection = 0;
    tabC?.index = 0;
  }

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);
    final snippetName = rootNodeOfSnippet()?.name;
    final spState = snippetName != null
        ? fsdui.snippetBuilderStates[snippetName]
        : null;
    if (spState == null) return const Placeholder();
    return PreferredSize(
      preferredSize: const Size.fromHeight(100), //tabBar.preferredSize,
      child: Container(
        color: bgColor?.flutterValue ?? Colors.grey,
        child: TabBarWidget(
          node: this,
          spState: spState,
          parentNode: parentNode,
        ),
      ),
    );
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "TabBar";
}

// class ColoredTabBar extends Container implements PreferredSizeWidget {
//   ColoredTabBar(this.color, this.tabBar);
//
//   final Color color;
//   final TabBar tabBar;
//
//   @override
//   Size get preferredSize => tabBar.preferredSize;
//
//   @override
//   Widget build(BuildContext context) => Container(
//         color: color,
//         child: tabBar,
//       );
// }

class TabBarWidget extends StatefulWidget {
  final TabBarNode node;
  final SnippetBuilderState spState;
  final SNode? parentNode;

  const TabBarWidget({
    required this.node,
    required this.spState,
    this.parentNode,
  });

  @override
  State<TabBarWidget> createState() => TabBarWidgetState();
}

class TabBarWidgetState extends State<TabBarWidget> {
  late TabController _tabC;

  @override
  void initState() {
    super.initState();
    _tabC = TabController(
      vsync: widget.spState,
      length: widget.node.children.length,
    );
    _tabC.addListener(_tabListenerF);
    widget.node.tabC = _tabC;
    widget.spState.tabBars[widget.node.tabBarName] = widget.node;
  }

  @override
  void didUpdateWidget(TabBarWidget old) {
    super.didUpdateWidget(old);
    final newLength = widget.node.children.length;
    if (_tabC.length != newLength) {
      _tabC.removeListener(_tabListenerF);
      _tabC.dispose();
      _tabC = TabController(vsync: widget.spState, length: newLength);
      _tabC.addListener(_tabListenerF);
      widget.node.tabC = _tabC;
      widget.spState.tabBars[widget.node.tabBarName] = widget.node;
    }
    _tabC.index = min(widget.node.selection ?? 0, newLength - 1);
  }

  void _tabListenerF() => widget.node._tabListenerF();

  @override
  void dispose() {
    _tabC.removeListener(_tabListenerF);
    _tabC.dispose();
    widget.node.tabC = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [];
    for (SNode node in widget.node.children) {
      tabs.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: node is TextNode
              ? Tab(key: node.createNodeWidgetGK(), text: (node).text)
              : Tab(child: node.build(context, widget.parentNode)),
        ),
      );
    }
    return TabBar(
      key: widget.node.createNodeWidgetGK(),
      controller: _tabC,
      tabs: tabs,
      labelColor: widget.node.selectedLabelColor?.flutterValue,
      unselectedLabelColor: widget.node.unselectedLabelColor?.flutterValue,
      labelPadding: EdgeInsets.all(10),
      labelStyle: widget.node.labelTSPropGroup.toTextStyle(context),
      indicatorColor: widget.node.indicatorColor?.flutterValue,
      indicatorWeight: widget.node.indicatorWeight ?? 2.0,
      indicator: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
