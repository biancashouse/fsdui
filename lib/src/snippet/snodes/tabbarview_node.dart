// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

part 'tabbarview_node.mapper.dart';

@MappableClass()
class TabBarViewNode extends MC with TabBarViewNodeMappable {

  TabBarViewNode({super.name, required super.children});

  TabBarNode? get tabBarNode =>
      rootNodeOfSnippet()?.findDescendant(TabBarNode) as TabBarNode?;

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
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
    final tb = tabBarNode;
    if (tb == null) {
      return Error(
        key: createNodeWidgetGK(),
        FLUTTER_TYPE,
        errorMsg: 'No TabBarNode found in snippet tree.',
      );
    }
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
        // Listener.onPointerDown fires on the very first touch event, before
        // scroll physics run. unfocus() schedules a microtask that detaches the
        // active web DOM input element; because microtasks run between Dart
        // event-loop tasks the DOM is detached before the swipe's layout frame,
        // preventing "targeted input element must be the active input element".
        return Listener(
          onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          child: TabBarView(
            key: createNodeWidgetGK(),
            controller: controller,
            children: childWidgets,
          ),
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
