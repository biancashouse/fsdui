// // ignore_for_file: constant_identifier_names
//
// import 'package:dart_mappable/dart_mappable.dart';
// import 'package:flutter/material.dart';
// import 'package:fsdui/fsdui.dart';
// import 'package:fsdui/src/model/dashboard_layout_item_model.dart';
// import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
// import 'package:fsdui/src/snippet/snodes/mixin_dashboard_controller_node.dart';
// import 'package:sliver_dashboard/sliver_dashboard.dart';
//
// part 'dashboard_node.mapper.dart';
//
// // A self-contained, draggable/resizable grid dashboard.
// //
// // Builds the interactive `Dashboard` widget (which wraps DashboardOverlay +
// // CustomScrollView + SliverDashboard internally) while this node is being
// // edited, so an editor user can rearrange children; the resulting layout is
// // captured into `savedLayout`. For everyone else it builds a plain
// // CustomScrollView + SliverDashboard (no DashboardOverlay), which renders
// // the same saved layout without the interaction/gesture overhead.
// @MappableClass()
// class DashboardNode extends SNode
//     with MC, DashboardControllerNode, DashboardNodeMappable {
//   @override
//   List<SNode> children;
//
//   @override
//   int? slotCount;
//
//   @override
//   List<String> sectionHeaderChildUids;
//
//   @override
//   Map<String, DashboardLayoutItemModel> savedLayout;
//
//   DashboardNode({
//     super.name,
//     this.slotCount,
//     this.sectionHeaderChildUids = const [],
//     this.savedLayout = const {},
//     required this.children,
//   });
//
//   @override
//   List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
//     ...dashboardPropertyNodes(context),
//     FlutterDocPNode(
//       buttonLabel: 'Dashboard',
//       webLink: 'https://pub.dev/packages/sliver_dashboard',
//       snode: this,
//       name: 'fyi',
//     ),
//   ];
//
//   @override
//   Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
//     setParent(parentNode);
//
//     // Same "this node's own interactive editor vs. its plain render" check
//     // QuillTextNode uses, so the drag/resize gestures don't fight with the
//     // structural tree-editing (tappable border rects) overlay.
//     final isEditingLayout = false;
//         // fsdui.canEditAnyContent() &&
//         // fsdui.snippetBeingEdited == null &&
//         // !fsdui.capiBloc.showTappableBorderRects();
//
//     if (isEditingLayout) {
//       return Dashboard(
//         key: createNodeWidgetGK(),
//         controller: dashboardController,
//         itemBuilder: dashboardItemBuilder,
//         sectionHeaderBuilder: dashboardItemBuilder,
//       );
//     }
//
//     return CustomScrollView(
//       key: createNodeWidgetGK(),
//       slivers: [
//         DashboardControllerProvider(
//           controller: dashboardController,
//           child: SliverDashboard(
//             itemBuilder: dashboardItemBuilder,
//             sectionHeaderBuilder: dashboardItemBuilder,
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   String toString() => FLUTTER_TYPE;
//
//   static const String FLUTTER_TYPE = "Dashboard";
// }
