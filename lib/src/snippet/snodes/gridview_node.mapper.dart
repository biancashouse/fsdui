// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'gridview_node.dart';

class GridViewNodeMapper extends SubClassMapperBase<GridViewNode> {
  GridViewNodeMapper._();

  static GridViewNodeMapper? _instance;
  static GridViewNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GridViewNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      AxisEnumMapper.ensureInitialized();
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GridViewNode';

  static String? _$name(GridViewNode v) => v.name;
  static const Field<GridViewNode, String> _f$name =
      Field('name', _$name, opt: true);
  static AxisEnum _$scrollDirection(GridViewNode v) => v.scrollDirection;
  static const Field<GridViewNode, AxisEnum> _f$scrollDirection = Field(
      'scrollDirection', _$scrollDirection,
      opt: true, def: AxisEnum.vertical);
  static bool? _$shrinkWrap(GridViewNode v) => v.shrinkWrap;
  static const Field<GridViewNode, bool> _f$shrinkWrap =
      Field('shrinkWrap', _$shrinkWrap, opt: true);
  static EdgeInsets? _$padding(GridViewNode v) => v.padding;
  static const Field<GridViewNode, EdgeInsets> _f$padding =
      Field('padding', _$padding, opt: true);
  static double? _$mainAxisSpacing(GridViewNode v) => v.mainAxisSpacing;
  static const Field<GridViewNode, double> _f$mainAxisSpacing =
      Field('mainAxisSpacing', _$mainAxisSpacing, opt: true);
  static double? _$crossAxisSpacing(GridViewNode v) => v.crossAxisSpacing;
  static const Field<GridViewNode, double> _f$crossAxisSpacing =
      Field('crossAxisSpacing', _$crossAxisSpacing, opt: true);
  static int? _$crossAxisCount(GridViewNode v) => v.crossAxisCount;
  static const Field<GridViewNode, int> _f$crossAxisCount =
      Field('crossAxisCount', _$crossAxisCount, opt: true);
  static List<SNode> _$children(GridViewNode v) => v.children;
  static const Field<GridViewNode, List<SNode>> _f$children =
      Field('children', _$children);
  static String _$uid(GridViewNode v) => v.uid;
  static const Field<GridViewNode, String> _f$uid =
      Field('uid', _$uid, mode: FieldMode.member);
  static List<String>? _$tags(GridViewNode v) => v.tags;
  static const Field<GridViewNode, List<String>> _f$tags =
      Field('tags', _$tags, mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(GridViewNode v) =>
      v.treeNodeGK;
  static const Field<GridViewNode, GlobalKey<State<StatefulWidget>>>
      _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(GridViewNode v) => v.isExpanded;
  static const Field<GridViewNode, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, mode: FieldMode.member);
  static bool? _$hidePropertiesWhileDragging(GridViewNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<GridViewNode, bool> _f$hidePropertiesWhileDragging = Field(
      'hidePropertiesWhileDragging', _$hidePropertiesWhileDragging,
      mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(GridViewNode v) => v.nodeGK;
  static const Field<GridViewNode, GlobalKey<State<StatefulWidget>>> _f$nodeGK =
      Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<GridViewNode> fields = const {
    #name: _f$name,
    #scrollDirection: _f$scrollDirection,
    #shrinkWrap: _f$shrinkWrap,
    #padding: _f$padding,
    #mainAxisSpacing: _f$mainAxisSpacing,
    #crossAxisSpacing: _f$crossAxisSpacing,
    #crossAxisCount: _f$crossAxisCount,
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
  final dynamic discriminatorValue = 'GridViewNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static GridViewNode _instantiate(DecodingData data) {
    return GridViewNode(
        name: data.dec(_f$name),
        scrollDirection: data.dec(_f$scrollDirection),
        shrinkWrap: data.dec(_f$shrinkWrap),
        padding: data.dec(_f$padding),
        mainAxisSpacing: data.dec(_f$mainAxisSpacing),
        crossAxisSpacing: data.dec(_f$crossAxisSpacing),
        crossAxisCount: data.dec(_f$crossAxisCount),
        children: data.dec(_f$children));
  }

  @override
  final Function instantiate = _instantiate;

  static GridViewNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GridViewNode>(map);
  }

  static GridViewNode fromJson(String json) {
    return ensureInitialized().decodeJson<GridViewNode>(json);
  }
}

mixin GridViewNodeMappable {
  String toJson() {
    return GridViewNodeMapper.ensureInitialized()
        .encodeJson<GridViewNode>(this as GridViewNode);
  }

  Map<String, dynamic> toMap() {
    return GridViewNodeMapper.ensureInitialized()
        .encodeMap<GridViewNode>(this as GridViewNode);
  }

  GridViewNodeCopyWith<GridViewNode, GridViewNode, GridViewNode> get copyWith =>
      _GridViewNodeCopyWithImpl<GridViewNode, GridViewNode>(
          this as GridViewNode, $identity, $identity);
  @override
  String toString() {
    return GridViewNodeMapper.ensureInitialized()
        .stringifyValue(this as GridViewNode);
  }

  @override
  bool operator ==(Object other) {
    return GridViewNodeMapper.ensureInitialized()
        .equalsValue(this as GridViewNode, other);
  }

  @override
  int get hashCode {
    return GridViewNodeMapper.ensureInitialized()
        .hashValue(this as GridViewNode);
  }
}

extension GridViewNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GridViewNode, $Out> {
  GridViewNodeCopyWith<$R, GridViewNode, $Out> get $asGridViewNode =>
      $base.as((v, t, t2) => _GridViewNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GridViewNodeCopyWith<$R, $In extends GridViewNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call(
      {String? name,
      AxisEnum? scrollDirection,
      bool? shrinkWrap,
      EdgeInsets? padding,
      double? mainAxisSpacing,
      double? crossAxisSpacing,
      int? crossAxisCount,
      List<SNode>? children});
  GridViewNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GridViewNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GridViewNode, $Out>
    implements GridViewNodeCopyWith<$R, GridViewNode, $Out> {
  _GridViewNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GridViewNode> $mapper =
      GridViewNodeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children =>
      ListCopyWith($value.children, (v, t) => v.copyWith.$chain(t),
          (v) => call(children: v));
  @override
  $R call(
          {Object? name = $none,
          AxisEnum? scrollDirection,
          Object? shrinkWrap = $none,
          Object? padding = $none,
          Object? mainAxisSpacing = $none,
          Object? crossAxisSpacing = $none,
          Object? crossAxisCount = $none,
          List<SNode>? children}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (scrollDirection != null) #scrollDirection: scrollDirection,
        if (shrinkWrap != $none) #shrinkWrap: shrinkWrap,
        if (padding != $none) #padding: padding,
        if (mainAxisSpacing != $none) #mainAxisSpacing: mainAxisSpacing,
        if (crossAxisSpacing != $none) #crossAxisSpacing: crossAxisSpacing,
        if (crossAxisCount != $none) #crossAxisCount: crossAxisCount,
        if (children != null) #children: children
      }));
  @override
  GridViewNode $make(CopyWithData data) => GridViewNode(
      name: data.get(#name, or: $value.name),
      scrollDirection: data.get(#scrollDirection, or: $value.scrollDirection),
      shrinkWrap: data.get(#shrinkWrap, or: $value.shrinkWrap),
      padding: data.get(#padding, or: $value.padding),
      mainAxisSpacing: data.get(#mainAxisSpacing, or: $value.mainAxisSpacing),
      crossAxisSpacing:
          data.get(#crossAxisSpacing, or: $value.crossAxisSpacing),
      crossAxisCount: data.get(#crossAxisCount, or: $value.crossAxisCount),
      children: data.get(#children, or: $value.children));

  @override
  GridViewNodeCopyWith<$R2, GridViewNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GridViewNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
