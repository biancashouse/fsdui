// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'css_grid_node.dart';

class CSSGridNodeMapper extends SubClassMapperBase<CSSGridNode> {
  CSSGridNodeMapper._();

  static CSSGridNodeMapper? _instance;
  static CSSGridNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CSSGridNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      CSSGridAutoPlacementEnumModelMapper.ensureInitialized();
      CSSGridFitEnumModelMapper.ensureInitialized();
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CSSGridNode';

  static String? _$name(CSSGridNode v) => v.name;
  static const Field<CSSGridNode, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String _$columnSizesSpec(CSSGridNode v) => v.columnSizesSpec;
  static const Field<CSSGridNode, String> _f$columnSizesSpec = Field(
    'columnSizesSpec',
    _$columnSizesSpec,
    opt: true,
    def: '1fr 1fr',
  );
  static String _$rowSizesSpec(CSSGridNode v) => v.rowSizesSpec;
  static const Field<CSSGridNode, String> _f$rowSizesSpec = Field(
    'rowSizesSpec',
    _$rowSizesSpec,
    opt: true,
    def: 'auto',
  );
  static double? _$columnGap(CSSGridNode v) => v.columnGap;
  static const Field<CSSGridNode, double> _f$columnGap = Field(
    'columnGap',
    _$columnGap,
    opt: true,
  );
  static double? _$rowGap(CSSGridNode v) => v.rowGap;
  static const Field<CSSGridNode, double> _f$rowGap = Field(
    'rowGap',
    _$rowGap,
    opt: true,
  );
  static CSSGridAutoPlacementEnumModel? _$autoPlacement(CSSGridNode v) =>
      v.autoPlacement;
  static const Field<CSSGridNode, CSSGridAutoPlacementEnumModel>
  _f$autoPlacement = Field('autoPlacement', _$autoPlacement, opt: true);
  static CSSGridFitEnumModel? _$gridFit(CSSGridNode v) => v.gridFit;
  static const Field<CSSGridNode, CSSGridFitEnumModel> _f$gridFit = Field(
    'gridFit',
    _$gridFit,
    opt: true,
  );
  static List<SNode> _$children(CSSGridNode v) => v.children;
  static const Field<CSSGridNode, List<SNode>> _f$children = Field(
    'children',
    _$children,
  );
  static String _$uid(CSSGridNode v) => v.uid;
  static const Field<CSSGridNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(CSSGridNode v) => v.tags;
  static const Field<CSSGridNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(CSSGridNode v) =>
      v.treeNodeGK;
  static const Field<CSSGridNode, GlobalKey<State<StatefulWidget>>>
  _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(CSSGridNode v) => v.isExpanded;
  static const Field<CSSGridNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(CSSGridNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<CSSGridNode, bool> _f$hidePropertiesWhileDragging = Field(
    'hidePropertiesWhileDragging',
    _$hidePropertiesWhileDragging,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(CSSGridNode v) => v.nodeGK;
  static const Field<CSSGridNode, GlobalKey<State<StatefulWidget>>> _f$nodeGK =
      Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<CSSGridNode> fields = const {
    #name: _f$name,
    #columnSizesSpec: _f$columnSizesSpec,
    #rowSizesSpec: _f$rowSizesSpec,
    #columnGap: _f$columnGap,
    #rowGap: _f$rowGap,
    #autoPlacement: _f$autoPlacement,
    #gridFit: _f$gridFit,
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
  final dynamic discriminatorValue = 'CSSGridNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static CSSGridNode _instantiate(DecodingData data) {
    return CSSGridNode(
      name: data.dec(_f$name),
      columnSizesSpec: data.dec(_f$columnSizesSpec),
      rowSizesSpec: data.dec(_f$rowSizesSpec),
      columnGap: data.dec(_f$columnGap),
      rowGap: data.dec(_f$rowGap),
      autoPlacement: data.dec(_f$autoPlacement),
      gridFit: data.dec(_f$gridFit),
      children: data.dec(_f$children),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CSSGridNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CSSGridNode>(map);
  }

  static CSSGridNode fromJson(String json) {
    return ensureInitialized().decodeJson<CSSGridNode>(json);
  }
}

mixin CSSGridNodeMappable {
  String toJson() {
    return CSSGridNodeMapper.ensureInitialized().encodeJson<CSSGridNode>(
      this as CSSGridNode,
    );
  }

  Map<String, dynamic> toMap() {
    return CSSGridNodeMapper.ensureInitialized().encodeMap<CSSGridNode>(
      this as CSSGridNode,
    );
  }

  CSSGridNodeCopyWith<CSSGridNode, CSSGridNode, CSSGridNode> get copyWith =>
      _CSSGridNodeCopyWithImpl<CSSGridNode, CSSGridNode>(
        this as CSSGridNode,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CSSGridNodeMapper.ensureInitialized().stringifyValue(
      this as CSSGridNode,
    );
  }

  @override
  bool operator ==(Object other) {
    return CSSGridNodeMapper.ensureInitialized().equalsValue(
      this as CSSGridNode,
      other,
    );
  }

  @override
  int get hashCode {
    return CSSGridNodeMapper.ensureInitialized().hashValue(this as CSSGridNode);
  }
}

extension CSSGridNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CSSGridNode, $Out> {
  CSSGridNodeCopyWith<$R, CSSGridNode, $Out> get $asCSSGridNode =>
      $base.as((v, t, t2) => _CSSGridNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CSSGridNodeCopyWith<$R, $In extends CSSGridNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call({
    String? name,
    String? columnSizesSpec,
    String? rowSizesSpec,
    double? columnGap,
    double? rowGap,
    CSSGridAutoPlacementEnumModel? autoPlacement,
    CSSGridFitEnumModel? gridFit,
    List<SNode>? children,
  });
  CSSGridNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CSSGridNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CSSGridNode, $Out>
    implements CSSGridNodeCopyWith<$R, CSSGridNode, $Out> {
  _CSSGridNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CSSGridNode> $mapper =
      CSSGridNodeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children =>
      ListCopyWith(
        $value.children,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(children: v),
      );
  @override
  $R call({
    Object? name = $none,
    String? columnSizesSpec,
    String? rowSizesSpec,
    Object? columnGap = $none,
    Object? rowGap = $none,
    Object? autoPlacement = $none,
    Object? gridFit = $none,
    List<SNode>? children,
  }) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (columnSizesSpec != null) #columnSizesSpec: columnSizesSpec,
      if (rowSizesSpec != null) #rowSizesSpec: rowSizesSpec,
      if (columnGap != $none) #columnGap: columnGap,
      if (rowGap != $none) #rowGap: rowGap,
      if (autoPlacement != $none) #autoPlacement: autoPlacement,
      if (gridFit != $none) #gridFit: gridFit,
      if (children != null) #children: children,
    }),
  );
  @override
  CSSGridNode $make(CopyWithData data) => CSSGridNode(
    name: data.get(#name, or: $value.name),
    columnSizesSpec: data.get(#columnSizesSpec, or: $value.columnSizesSpec),
    rowSizesSpec: data.get(#rowSizesSpec, or: $value.rowSizesSpec),
    columnGap: data.get(#columnGap, or: $value.columnGap),
    rowGap: data.get(#rowGap, or: $value.rowGap),
    autoPlacement: data.get(#autoPlacement, or: $value.autoPlacement),
    gridFit: data.get(#gridFit, or: $value.gridFit),
    children: data.get(#children, or: $value.children),
  );

  @override
  CSSGridNodeCopyWith<$R2, CSSGridNode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CSSGridNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

