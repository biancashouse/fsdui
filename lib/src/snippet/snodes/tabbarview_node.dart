// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/bool_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

part 'tabbarview_node.mapper.dart';

@MappableClass()
class TabBarViewNode extends SNode with MC, TabBarViewNodeMappable {
  @override
  List<SNode> children;

  /// Name of the TabBarNode driving this view, when it lives outside this
  /// node's own snippet tree (e.g. pinned in a SliverAppBar.bottom while
  /// this view scrolls in a sibling sliver) and so can't be found by
  /// ancestry. Looked up reactively via fsdui.tabBarNodeNotifierFor(), so
  /// it doesn't matter whether this node or its TabBarNode builds/mounts
  /// first. When null, falls back to the ancestry-based lookup for
  /// same-tree layouts.
  String? tabBarName;

  /// Whether tabs can be changed by swiping/dragging, not just by tapping
  /// the TabBar. Defaults to true, matching Flutter's own TabBarView
  /// default. Turn off when a child (e.g. a CarouselView) also wants
  /// horizontal drag gestures — TabBarView's own swipe recognizer competes
  /// with and usually wins over a nested horizontally-scrolling child's,
  /// leaving that child unable to respond to taps/drags at all. Tapping
  /// the TabBar still works either way.
  bool? enableSwipe;

  TabBarViewNode({
    super.name,
    this.tabBarName,
    this.enableSwipe,
    required this.children,
  });

  @override
  List<SNode>? get ownChildren => children;

  /// Ancestry-based lookup, used only when [tabBarName] is null.
  TabBarNode? get tabBarNode {
    final rn = rootNodeOfSnippet();
    return rn?.findDescendant(TabBarNode) as TabBarNode?;
  }

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
    BoolPNode(
      snode: this,
      name: 'enableSwipe',
      boolValue: enableSwipe,
      onBoolChange: (newValue) =>
          refreshWithUpdate(context, () => enableSwipe = newValue ?? true),
    ),
    FlutterDocPNode(
      buttonLabel: 'TabBarView',
      webLink: 'https://api.flutter.dev/flutter/material/TabBarView-class.html',
      snode: this,
      name: 'fyi',
    ),
  ];

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    setParent(parentNode);

    if (tabBarName != null) {
      // Reactive: waits for TabBarWidgetState to publish itself, whichever
      // of the two nodes happens to build/mount first.
      return ValueListenableBuilder<TabBarNode?>(
        valueListenable: fsdui.tabBarNodeNotifierFor(tabBarName!),
        builder: (context, tb, _) =>
            tb == null ? const SizedBox.shrink() : _buildWithTabBar(context, tb),
      );
    }

    final tb = tabBarNode;
    if (tb == null) {
      return Error(
        key: createNodeWidgetGK(),
        FLUTTER_TYPE,
        errorMsg: 'No TabBarNode found in snippet tree.',
      );
    }
    return _buildWithTabBar(context, tb);
  }

  Widget _buildWithTabBar(BuildContext context, TabBarNode tb) {
    return ValueListenableBuilder<TabController?>(
      valueListenable: tb.tabCNotifier,
      builder: (context, controller, _) {
        if (controller == null) return const SizedBox.shrink();
        final childWidgets = children
            .map((node) => node.build(context, this))
            .toList();
        if (tb.children.length != children.length) {
          return Error(
            key: const ValueKey('tabbarview-mismatch'),
            FLUTTER_TYPE,
            errorMsg: 'TabBar (${tb.children.length}) and TabBarView '
                '(${children.length}) child counts do not match.',
          );
        }
        // Stable key preserves the element across controller changes, preventing
        // element teardown mid-animation (assert(attached) in getTransformTo).
        final tabBarView = TabBarView(
          key: createNodeWidgetGK(),
          controller: controller,
          physics: (enableSwipe ?? true) ? null : const NeverScrollableScrollPhysics(),
          children: childWidgets,
        );

        if (!(enableSwipe ?? true)) {
          // No swipe gesture is possible with drag disabled, so there's no
          // DOM-focus/layout race for the Listener below to guard against
          // — and unconditionally unfocusing on every pointer-down would
          // otherwise make any editable content inside a tab (e.g. a
          // QuillTextNode's FocusAwareQuillEditor) impossible to focus:
          // the unfocus() fires on the same tap that's trying to focus it.
          return tabBarView;
        }

        // Listener.onPointerDown fires on the very first touch event, before
        // scroll physics run. unfocus() schedules a microtask that detaches the
        // active web DOM input element; because microtasks run between Dart
        // event-loop tasks the DOM is detached before the swipe's layout frame,
        // preventing "targeted input element must be the active input element".
        return Listener(
          onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          child: tabBarView,
        );
      },
    );
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
