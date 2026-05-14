// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/color_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/pnodes/text_style_pnodes.dart';

part 'tabbar_node.mapper.dart';

@MappableClass()
class TabBarNode extends MC with TabBarNodeMappable {
  ColorModel? bgColor;
  TextStyleProperties labelTSPropGroup;
  ColorModel? selectedLabelColor;
  ColorModel? unselectedLabelColor;
  ColorModel? indicatorColor;
  double? indicatorWeight;
  int? selection;

  TabBarNode({
    super.name,
    this.bgColor,
    required this.labelTSPropGroup,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.selection,
    required super.children,
  });

  ///  - TabBarNode.tabC is now a getter/setter backed by tabCNotifier (ValueNotifier<TabController?>). All existing call sites
  //   (tabC?.index, tabC?.dispose, etc.) work identically — they see the same TabController? value.
  //   - TabBarViewNode.buildFlutterWidget wraps the TabBarView in a ValueListenableBuilder on tb.tabCNotifier. On first build controller
  //   is null → renders SizedBox.shrink() (invisible, no crash). The moment TabBarWidgetState.initState sets widget.node.tabC = _tabC,
  //   tabCNotifier fires, the builder re-runs with the real controller, and the TabBarView appears — no polling, no post-frame callbacks,
  //   no forced BLoC refresh needed.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final tabCNotifier = ValueNotifier<TabController?>(null);

  TabController? get tabC => tabCNotifier.value;
  set tabC(TabController? c) => tabCNotifier.value = c;

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
    return PreferredSize(
      preferredSize: const Size.fromHeight(100), //tabBar.preferredSize,
      child: Container(
        color: bgColor?.flutterValue ?? Colors.grey,
        child: TabBarWidget(
          node: this,
          parentNode: parentNode,
        ),
      ),
    );
  }

  @override
  Widget insertItemMenuAnchor(
    BuildContext context, {
    required NodeAction action,
    String? label,
    Color? bgColor,
    String? tooltip,
    key,
  }) {
    if (action == NodeAction.addChild) {
      return IconButton(
        key: key,
        padding: EdgeInsets.zero,
        onPressed: () => fsdui.capiBloc.add(AppendChild(nodeType: TabNode)),
        icon: Icon(Icons.add_box, color: bgColor),
        tooltip: 'Add Tab',
        iconSize: 40,
      );
    }
    return super.insertItemMenuAnchor(
      context,
      action: action,
      label: label,
      bgColor: bgColor,
      tooltip: tooltip,
      key: key,
    );
  }

  @override
  List<Widget> menuAnchorWidgets_Append(
    BuildContext context,
    NodeAction action,
    bool? skipHeading,
  ) => [
    ...super.menuAnchorWidgets_Heading(context, action),
    menuItemButton(context, "Tab", TabNode, action),
  ];

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
  final SNode? parentNode;

  const TabBarWidget({
    required this.node,
    this.parentNode,
  });

  @override
  State<TabBarWidget> createState() => TabBarWidgetState();
}

class TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabC;

  @override
  void initState() {
    super.initState();
    _tabC = TabController(
      vsync: this,
      length: widget.node.children.length,
    );
    _tabC.addListener(_tabListenerF);
    // Deferring via addPostFrameCallback means the notification fires
    // after the current frame's build/layout/paint is fully complete, at
    // which point setState from ValueListenableBuilder is legal and the
    // TabBarView renders correctly.
    fsdui.afterNextBuildDo((){
      widget.node.tabC = _tabC;
    });
  }

  @override
  void didUpdateWidget(TabBarWidget old) {
    super.didUpdateWidget(old);
    final newLength = widget.node.children.length;
    if (_tabC.length != newLength) {
      _tabC.removeListener(_tabListenerF);
      _tabC.dispose();
      _tabC = TabController(vsync: this, length: newLength);
      _tabC.addListener(_tabListenerF);
      widget.node.tabC = _tabC;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final selected = fsdui.selectedNode;
      final selectedIdx = selected is TabNode
          ? widget.node.children.indexOf(selected)
          : -1;
      final targetIdx = selectedIdx >= 0
          ? selectedIdx
          : min(widget.node.selection ?? 0, widget.node.children.length - 1);
      _tabC.animateTo(targetIdx);
    });
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
          child: node.build(context, widget.node),
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
