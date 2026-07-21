// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dashboard_node.dart';

class DashboardNodeMapper extends SubClassMapperBase<DashboardNode> {
  DashboardNodeMapper._();

  static DashboardNodeMapper? _instance;
  static DashboardNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DashboardNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      DashboardLayoutItemModelMapper.ensureInitialized();
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DashboardNode';

  static String? _$name(DashboardNode v) => v.name;
  static const Field<DashboardNode, String> _f$name =
      Field('name', _$name, opt: true);
  static int? _$slotCount(DashboardNode v) => v.slotCount;
  static const Field<DashboardNode, int> _f$slotCount =
      Field('slotCount', _$slotCount, opt: true);
  static List<String> _$sectionHeaderChildUids(DashboardNode v) =>
      v.sectionHeaderChildUids;
  static const Field<DashboardNode, List<String>> _f$sectionHeaderChildUids =
      Field('sectionHeaderChildUids', _$sectionHeaderChildUids,
          opt: true, def: const []);
  static Map<String, DashboardLayoutItemModel> _$savedLayout(DashboardNode v) =>
      v.savedLayout;
  static const Field<DashboardNode, Map<String, DashboardLayoutItemModel>>
      _f$savedLayout =
      Field('savedLayout', _$savedLayout, opt: true, def: const {});
  static List<SNode> _$children(DashboardNode v) => v.children;
  static const Field<DashboardNode, List<SNode>> _f$children =
      Field('children', _$children);
  static String _$uid(DashboardNode v) => v.uid;
  static const Field<DashboardNode, String> _f$uid =
      Field('uid', _$uid, mode: FieldMode.member);
  static List<String>? _$tags(DashboardNode v) => v.tags;
  static const Field<DashboardNode, List<String>> _f$tags =
      Field('tags', _$tags, mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(DashboardNode v) =>
      v.treeNodeGK;
  static const Field<DashboardNode, GlobalKey<State<StatefulWidget>>>
      _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(DashboardNode v) => v.isExpanded;
  static const Field<DashboardNode, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, mode: FieldMode.member);
  static bool? _$hidePropertiesWhileDragging(DashboardNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<DashboardNode, bool> _f$hidePropertiesWhileDragging =
      Field('hidePropertiesWhileDragging', _$hidePropertiesWhileDragging,
          mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(DashboardNode v) =>
      v.nodeGK;
  static const Field<DashboardNode, GlobalKey<State<StatefulWidget>>>
      _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<DashboardNode> fields = const {
    #name: _f$name,
    #slotCount: _f$slotCount,
    #sectionHeaderChildUids: _f$sectionHeaderChildUids,
    #savedLayout: _f$savedLayout,
    #children: _f$children,
    #uid: _f$uid,
    #tags: _f$tags,
    #treeNodeGK: _f$treeNodeGK,
    #isExpanded: _f$isExpanded,
    #hidePropertiesWhileDragging: _f$hidePropertiesWhileDragging,
    #nodeGK: _f$nodeGK,
  };

  @override
  final String discriminatorKey = 'DK:snode';
  @override
  final dynamic discriminatorValue = 'DashboardNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static DashboardNode _instantiate(DecodingData data) {
    return DashboardNode(
        name: data.dec(_f$name),
        slotCount: data.dec(_f$slotCount),
        sectionHeaderChildUids: data.dec(_f$sectionHeaderChildUids),
        savedLayout: data.dec(_f$savedLayout),
        children: data.dec(_f$children));
  }

  @override
  final Function instantiate = _instantiate;

  static DashboardNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DashboardNode>(map);
  }

  static DashboardNode fromJson(String json) {
    return ensureInitialized().decodeJson<DashboardNode>(json);
  }
}

mixin DashboardNodeMappable {
  String toJson() {
    return DashboardNodeMapper.ensureInitialized()
        .encodeJson<DashboardNode>(this as DashboardNode);
  }

  Map<String, dynamic> toMap() {
    return DashboardNodeMapper.ensureInitialized()
        .encodeMap<DashboardNode>(this as DashboardNode);
  }

  DashboardNodeCopyWith<DashboardNode, DashboardNode, DashboardNode>
      get copyWith => _DashboardNodeCopyWithImpl<DashboardNode, DashboardNode>(
          this as DashboardNode, $identity, $identity);
  @override
  String toString() {
    return DashboardNodeMapper.ensureInitialized()
        .stringifyValue(this as DashboardNode);
  }

  @override
  bool operator ==(Object other) {
    return DashboardNodeMapper.ensureInitialized()
        .equalsValue(this as DashboardNode, other);
  }

  @override
  int get hashCode {
    return DashboardNodeMapper.ensureInitialized()
        .hashValue(this as DashboardNode);
  }
}

extension DashboardNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DashboardNode, $Out> {
  DashboardNodeCopyWith<$R, DashboardNode, $Out> get $asDashboardNode =>
      $base.as((v, t, t2) => _DashboardNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DashboardNodeCopyWith<$R, $In extends DashboardNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get sectionHeaderChildUids;
  MapCopyWith<
      $R,
      String,
      DashboardLayoutItemModel,
      DashboardLayoutItemModelCopyWith<$R, DashboardLayoutItemModel,
          DashboardLayoutItemModel>> get savedLayout;
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call(
      {String? name,
      int? slotCount,
      List<String>? sectionHeaderChildUids,
      Map<String, DashboardLayoutItemModel>? savedLayout,
      List<SNode>? children});
  DashboardNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DashboardNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DashboardNode, $Out>
    implements DashboardNodeCopyWith<$R, DashboardNode, $Out> {
  _DashboardNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DashboardNode> $mapper =
      DashboardNodeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get sectionHeaderChildUids => ListCopyWith(
          $value.sectionHeaderChildUids,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(sectionHeaderChildUids: v));
  @override
  MapCopyWith<
      $R,
      String,
      DashboardLayoutItemModel,
      DashboardLayoutItemModelCopyWith<$R, DashboardLayoutItemModel,
          DashboardLayoutItemModel>> get savedLayout => MapCopyWith(
      $value.savedLayout,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(savedLayout: v));
  @override
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children =>
      ListCopyWith($value.children, (v, t) => v.copyWith.$chain(t),
          (v) => call(children: v));
  @override
  $R call(
          {Object? name = $none,
          Object? slotCount = $none,
          List<String>? sectionHeaderChildUids,
          Map<String, DashboardLayoutItemModel>? savedLayout,
          List<SNode>? children}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (slotCount != $none) #slotCount: slotCount,
        if (sectionHeaderChildUids != null)
          #sectionHeaderChildUids: sectionHeaderChildUids,
        if (savedLayout != null) #savedLayout: savedLayout,
        if (children != null) #children: children
      }));
  @override
  DashboardNode $make(CopyWithData data) => DashboardNode(
      name: data.get(#name, or: $value.name),
      slotCount: data.get(#slotCount, or: $value.slotCount),
      sectionHeaderChildUids:
          data.get(#sectionHeaderChildUids, or: $value.sectionHeaderChildUids),
      savedLayout: data.get(#savedLayout, or: $value.savedLayout),
      children: data.get(#children, or: $value.children));

  @override
  DashboardNodeCopyWith<$R2, DashboardNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DashboardNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
