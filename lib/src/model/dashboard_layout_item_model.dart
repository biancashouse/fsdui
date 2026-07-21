import 'package:dart_mappable/dart_mappable.dart';

part 'dashboard_layout_item_model.mapper.dart';

// Persisted grid position/size for one DashboardNode child, captured from
// DashboardController.onLayoutChanged so an editor's drag/resize edits
// survive rebuilds and are reused for non-editor (SliverDashboard-only)
// rendering of the same node.
@MappableClass()
class DashboardLayoutItemModel with DashboardLayoutItemModelMappable {
  int x;
  int y;
  int w;
  int h;

  DashboardLayoutItemModel({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });
}
