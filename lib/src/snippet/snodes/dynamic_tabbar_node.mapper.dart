// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dynamic_tabbar_node.dart';

class DynamicTabBarNodeMapper extends SubClassMapperBase<DynamicTabBarNode> {
  DynamicTabBarNodeMapper._();

  static DynamicTabBarNodeMapper? _instance;
  static DynamicTabBarNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DynamicTabBarNodeMapper._());
      MCMapper.ensureInitialized().addSubMapper(_instance!);
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DynamicTabBarNode';

  static String? _$name(DynamicTabBarNode v) => v.name;
  static const Field<DynamicTabBarNode, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static List<SNode> _$children(DynamicTabBarNode v) => v.children;
  static const Field<DynamicTabBarNode, List<SNode>> _f$children = Field(
    'children',
    _$children,
  );
  static String _$uid(DynamicTabBarNode v) => v.uid;
  static const Field<DynamicTabBarNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(DynamicTabBarNode v) => v.tags;
  static const Field<DynamicTabBarNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(DynamicTabBarNode v) =>
      v.treeNodeGK;
  static const Field<DynamicTabBarNode, GlobalKey<State<StatefulWidget>>>
  _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(DynamicTabBarNode v) => v.isExpanded;
  static const Field<DynamicTabBarNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(DynamicTabBarNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<DynamicTabBarNode, bool> _f$hidePropertiesWhileDragging =
      Field(
        'hidePropertiesWhileDragging',
        _$hidePropertiesWhileDragging,
        mode: FieldMode.member,
      );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(DynamicTabBarNode v) =>
      v.nodeGK;
  static const Field<DynamicTabBarNode, GlobalKey<State<StatefulWidget>>>
  _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<DynamicTabBarNode> fields = const {
    #name: _f$name,
    #children: _f$children,
    #uid: _f$uid,
    #tags: _f$tags,
    #treeNodeGK: _f$treeNodeGK,
    #isExpanded: _f$isExpanded,
    #hidePropertiesWhileDragging: _f$hidePropertiesWhileDragging,
    #nodeGK: _f$nodeGK,
  };

  @override
  final String discriminatorKey = 'DK:mc';
  @override
  final dynamic discriminatorValue = 'DynamicTabBarNode';
  @override
  late final ClassMapperBase superMapper = MCMapper.ensureInitialized();

  @override
  final MappingHook superHook = ChainedHook([
    PropertyRenameHook('mc', 'DK:mc'),
    PropertyRenameHook('snode', 'DK:snode'),
  ]);

  static DynamicTabBarNode _instantiate(DecodingData data) {
    return DynamicTabBarNode(
      name: data.dec(_f$name),
      children: data.dec(_f$children),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DynamicTabBarNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DynamicTabBarNode>(map);
  }

  static DynamicTabBarNode fromJson(String json) {
    return ensureInitialized().decodeJson<DynamicTabBarNode>(json);
  }
}

mixin DynamicTabBarNodeMappable {
  String toJson() {
    return DynamicTabBarNodeMapper.ensureInitialized()
        .encodeJson<DynamicTabBarNode>(this as DynamicTabBarNode);
  }

  Map<String, dynamic> toMap() {
    return DynamicTabBarNodeMapper.ensureInitialized()
        .encodeMap<DynamicTabBarNode>(this as DynamicTabBarNode);
  }

  DynamicTabBarNodeCopyWith<
    DynamicTabBarNode,
    DynamicTabBarNode,
    DynamicTabBarNode
  >
  get copyWith =>
      _DynamicTabBarNodeCopyWithImpl<DynamicTabBarNode, DynamicTabBarNode>(
        this as DynamicTabBarNode,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DynamicTabBarNodeMapper.ensureInitialized().stringifyValue(
      this as DynamicTabBarNode,
    );
  }

  @override
  bool operator ==(Object other) {
    return DynamicTabBarNodeMapper.ensureInitialized().equalsValue(
      this as DynamicTabBarNode,
      other,
    );
  }

  @override
  int get hashCode {
    return DynamicTabBarNodeMapper.ensureInitialized().hashValue(
      this as DynamicTabBarNode,
    );
  }
}

extension DynamicTabBarNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DynamicTabBarNode, $Out> {
  DynamicTabBarNodeCopyWith<$R, DynamicTabBarNode, $Out>
  get $asDynamicTabBarNode => $base.as(
    (v, t, t2) => _DynamicTabBarNodeCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DynamicTabBarNodeCopyWith<
  $R,
  $In extends DynamicTabBarNode,
  $Out
>
    implements MCCopyWith<$R, $In, $Out> {
  @override
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call({String? name, List<SNode>? children});
  DynamicTabBarNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DynamicTabBarNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DynamicTabBarNode, $Out>
    implements DynamicTabBarNodeCopyWith<$R, DynamicTabBarNode, $Out> {
  _DynamicTabBarNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DynamicTabBarNode> $mapper =
      DynamicTabBarNodeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children =>
      ListCopyWith(
        $value.children,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(children: v),
      );
  @override
  $R call({Object? name = $none, List<SNode>? children}) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (children != null) #children: children,
    }),
  );
  @override
  DynamicTabBarNode $make(CopyWithData data) => DynamicTabBarNode(
    name: data.get(#name, or: $value.name),
    children: data.get(#children, or: $value.children),
  );

  @override
  DynamicTabBarNodeCopyWith<$R2, DynamicTabBarNode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DynamicTabBarNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

