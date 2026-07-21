import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/model/dashboard_layout_item_model.dart';
import 'package:fsdui/src/snippet/pnodes/bool_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/int_pnode.dart';
import 'package:sliver_dashboard/sliver_dashboard.dart';

// Shared by DashboardNode (currently the only user): builds a
// DashboardController from `children` (one LayoutItem per child, in child
// order, positioned from `savedLayout` once the editor has moved/resized
// them) and exposes the slotCount/section-header editing controls.
mixin DashboardControllerNode on SNode {
  abstract List<SNode> children;
  abstract int? slotCount;

  // uids of children flagged to render as full-width section header
  // barriers (via sectionHeaderBuilder) instead of as a regular grid item.
  abstract List<String> sectionHeaderChildUids;

  // Grid position/size per child uid, captured from the editor's
  // drag/resize interactions via DashboardController.onLayoutChanged.
  // Children not yet present here fall back to a default full-width row.
  abstract Map<String, DashboardLayoutItemModel> savedLayout;

  @JsonKey(includeFromJson: false, includeToJson: false)
  DashboardController? _dashboardController;

  LayoutItem _layoutItemFor(SNode childNode, int index) {
    final saved = savedLayout[childNode.uid];
    return LayoutItem(
      id: childNode.uid,
      x: saved?.x ?? 0,
      y: saved?.y ?? index,
      w: saved?.w ?? (slotCount ?? 8),
      h: saved?.h ?? 1,
      isSectionBarrier: sectionHeaderChildUids.contains(childNode.uid),
    );
  }

  // Lazily built so drag/resize state in the controller survives rebuilds.
  DashboardController get dashboardController =>
      _dashboardController ??= DashboardController(
        initialSlotCount: slotCount ?? 8,
        initialLayout: [
          for (final (index, childNode) in children.indexed)
            _layoutItemFor(childNode, index),
        ],
        onLayoutChanged: (items, newSlotCount) {
          for (final item in items) {
            savedLayout[item.id] = DashboardLayoutItemModel(
              x: item.x,
              y: item.y,
              w: item.w,
              h: item.h,
            );
          }
          slotCount = newSlotCount;
          snippetInfo()?.notifyChange(rootNodeOfSnippet()!);
        },
      );

  Widget dashboardItemBuilder(BuildContext context, LayoutItem item) {
    for (final childNode in children) {
      if (childNode.uid == item.id) return childNode.build(context, this);
    }
    return const SizedBox.shrink();
  }

  List<PNode> dashboardPropertyNodes(BuildContext context) => [
    IntPNode(
      snode: this,
      name: 'slotCount',
      intValue: slotCount,
      onIntChange: (newValue) =>
          refreshWithUpdate(context, () => slotCount = newValue),
      calloutButtonSize: const Size(130, 20),
    ),
    for (final (index, childNode) in children.indexed)
      BoolPNode(
        snode: this,
        name: '${childNode.toString()} #${index + 1}: section header',
        boolValue: sectionHeaderChildUids.contains(childNode.uid),
        onBoolChange: (newValue) => refreshWithUpdate(context, () {
          sectionHeaderChildUids = (newValue ?? false)
              ? [...sectionHeaderChildUids, childNode.uid]
              : sectionHeaderChildUids
                    .where((uid) => uid != childNode.uid)
                    .toList();
        }),
      ),
  ];
}
