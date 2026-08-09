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
class TabBarNode extends SNode with MC, TabBarNodeMappable {
  @override
  List<SNode> children;

  Color? bgColor;
  TextStyleProperties labelTSPropGroup;
  Color? selectedLabelColor;
  Color? unselectedLabelColor;
  Color indicatorColor;
  double? indicatorWeight;
  int? selection;

  TabBarNode({
    super.name,
    this.bgColor,
    required this.labelTSPropGroup,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.indicatorColor = Colors.blue,
    this.indicatorWeight = 2.0,
    this.selection,
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

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
          ),
          ColorPNode(
            snode: this,
            name: 'selected label Color',
            color: selectedLabelColor,
            onColorChange: (newValue) =>
                refreshWithUpdate(context, () => selectedLabelColor = newValue),
          ),
          ColorPNode(
            snode: this,
            name: 'unselected label Color',
            color: unselectedLabelColor,
            onColorChange: (newValue) => refreshWithUpdate(
              context,
              () => unselectedLabelColor = newValue,
            ),
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
      preferredSize: const Size.fromHeight(60), //tabBar.preferredSize,
      child: Container(
        color: bgColor ?? Colors.white,
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
        onPressed: () => fsdui.capiBloc.add(AppendChild(nodeType: TextNode)),
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
    menuItemButton(context, "Tab", TextNode, action),
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

  const TabBarWidget({super.key, 
    required this.node,
    this.parentNode,
  });

  @override
  State<TabBarWidget> createState() => TabBarWidgetState();
}

class TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabC;

  // Multiple TabBarWidgetState instances can register under the same name
  // in quick succession (e.g. an old instance disposing while a new one for
  // the same underlying TabBarNode mounts) — since both wrap the *same*
  // SNode object, a plain `notifier.value == node` identity check can't
  // tell "am I still the current registrant" from "does the current
  // registrant merely happen to wrap the same node". This per-name token
  // records which State instance registered most recently, so a stale
  // instance's deferred dispose-cleanup can't clobber a newer instance's
  // registration.
  static final Map<String, Object> _activeRegistrationTokens = {};
  final Object _registrationToken = Object();

  @override
  void initState() {
    super.initState();

    // _tabC is created synchronously (not deferred) since build() below
    // reads it on the very first frame, before any deferred callback runs.
    _tabC = TabController(
      vsync: this,
      length: widget.node.children.length,
    );
    _tabC.addListener(_tabListenerF);

    // Both node-level assignments are deferred: this lets the
    // notifications fire after the current frame's build/layout/paint is
    // fully complete, at which point setState from a ValueListenableBuilder
    // (in a TabBarViewNode that's already listening, possibly in an
    // unrelated snippet tree) is legal and the TabBarView renders
    // correctly — regardless of whether that TabBarViewNode built before
    // or after this TabBarNode.
    fsdui.afterNextBuildDo(() {
      if (widget.node.name != null) {
        _activeRegistrationTokens[widget.node.name!] = _registrationToken;
        fsdui.tabBarNodeNotifierFor(widget.node.name!).value = widget.node;
      }
      widget.node.tabC = _tabC;
    });
  }

  @override
  void didUpdateWidget(TabBarWidget old) {
    super.didUpdateWidget(old);
    final newLength = widget.node.children.length;
    bool recreated = false;
    if (_tabC.length != newLength) {
      _tabC.removeListener(_tabListenerF);
      _tabC.dispose();
      _tabC = TabController(vsync: this, length: newLength);
      _tabC.addListener(_tabListenerF);
      recreated = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Assign tabC after the build phase to avoid firing tabCNotifier
      // (→ setState on _TabBarViewWidgetState) during build.
      if (recreated) widget.node.tabC = _tabC;
      // Don't interfere with a tab animation already in progress.
      // During animation, selection hasn't been updated yet by _tabListenerF
      // (which fires only when !indexIsChanging), so targetIdx would be stale
      // and animateTo would reverse the ongoing animation — causing
      // _TabBarViewState to call getTransformTo on transitional render objects.
      if (_tabC.indexIsChanging) return;
      final selected = fsdui.selectedNode;
      final selectedIdx = -1;
      // selected is TabNode
      //     ? widget.node.children.indexOf(selected)
      //     : -1;
      final targetIdx = selectedIdx >= 0
          ? selectedIdx
          : min(widget.node.selection ?? 0, widget.node.children.length - 1);
      if (_tabC.index != targetIdx) {
        _tabC.animateTo(targetIdx);
      }
    });
  }

  void _tabListenerF() => widget.node._tabListenerF();

  @override
  void dispose() {
    _tabC.removeListener(_tabListenerF);
    _tabC.dispose();

    // Flutter can call dispose() mid-build, while reconciling the element
    // tree (not only between frames) — e.g. when this widget is being
    // swapped out for a new instance. Clearing these notifiers here would
    // notify any listening ValueListenableBuilder while the framework is
    // still locked, so defer to right after the frame. Locals are
    // captured up front since `widget` is gone once dispose() returns.
    final node = widget.node;
    final name = node.name;
    final disposedTabC = _tabC;
    final myToken = _registrationToken;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (node.tabC == disposedTabC) node.tabC = null;
      if (name != null && identical(_activeRegistrationTokens[name], myToken)) {
        _activeRegistrationTokens.remove(name);
        fsdui.tabBarNodeNotifierFor(name).value = null;
      }
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [];
    for (SNode node in widget.node.children) {
      tabs.add(
        Tab(
          iconMargin: const EdgeInsets.symmetric(horizontal: 8),
          child: node.build(context, widget.node),
        ),
      );
    }
    return TabBar(
      key: widget.node.createNodeWidgetGK(),
      controller: _tabC,
      tabs: tabs,
      labelColor: widget.node.selectedLabelColor,
      unselectedLabelColor: widget.node.unselectedLabelColor,
      labelPadding: EdgeInsets.all(10),
      labelStyle: widget.node.labelTSPropGroup.toTextStyle(context),
      indicatorColor: Colors.white,//widget.node.indicatorColor,
      indicatorWeight: widget.node.indicatorWeight ?? 2.0,
      indicator:
      BoxDecoration(
        border: Border.all(color: Colors.white, width: 0),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
