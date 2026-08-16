// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'grid_placement_node.dart';

class GridPlacementNodeMapper extends SubClassMapperBase<GridPlacementNode> {
  GridPlacementNodeMapper._();

  static GridPlacementNodeMapper? _instance;
  static GridPlacementNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GridPlacementNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GridPlacementNode';

  static String? _$name(GridPlacementNode v) => v.name;
  static const Field<GridPlacementNode, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static int? _$columnStart(GridPlacementNode v) => v.columnStart;
  static const Field<GridPlacementNode, int> _f$columnStart = Field(
    'columnStart',
    _$columnStart,
    opt: true,
  );
  static int? _$columnSpan(GridPlacementNode v) => v.columnSpan;
  static const Field<GridPlacementNode, int> _f$columnSpan = Field(
    'columnSpan',
    _$columnSpan,
    opt: true,
  );
  static int? _$rowStart(GridPlacementNode v) => v.rowStart;
  static const Field<GridPlacementNode, int> _f$rowStart = Field(
    'rowStart',
    _$rowStart,
    opt: true,
  );
  static int? _$rowSpan(GridPlacementNode v) => v.rowSpan;
  static const Field<GridPlacementNode, int> _f$rowSpan = Field(
    'rowSpan',
    _$rowSpan,
    opt: true,
  );
  static SNode? _$child(GridPlacementNode v) => v.child;
  static const Field<GridPlacementNode, SNode> _f$child = Field(
    'child',
    _$child,
    opt: true,
  );
  static String _$uid(GridPlacementNode v) => v.uid;
  static const Field<GridPlacementNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(GridPlacementNode v) => v.tags;
  static const Field<GridPlacementNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(GridPlacementNode v) =>
      v.treeNodeGK;
  static const Field<GridPlacementNode, GlobalKey<State<StatefulWidget>>>
  _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(GridPlacementNode v) => v.isExpanded;
  static const Field<GridPlacementNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(GridPlacementNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<GridPlacementNode, bool> _f$hidePropertiesWhileDragging =
      Field(
        'hidePropertiesWhileDragging',
        _$hidePropertiesWhileDragging,
        mode: FieldMode.member,
      );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(GridPlacementNode v) =>
      v.nodeGK;
  static const Field<GridPlacementNode, GlobalKey<State<StatefulWidget>>>
  _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<GridPlacementNode> fields = const {
    #name: _f$name,
    #columnStart: _f$columnStart,
    #columnSpan: _f$columnSpan,
    #rowStart: _f$rowStart,
    #rowSpan: _f$rowSpan,
    #child: _f$child,
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
  final dynamic discriminatorValue = 'GridPlacementNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static GridPlacementNode _instantiate(DecodingData data) {
    return GridPlacementNode(
      name: data.dec(_f$name),
      columnStart: data.dec(_f$columnStart),
      columnSpan: data.dec(_f$columnSpan),
      rowStart: data.dec(_f$rowStart),
      rowSpan: data.dec(_f$rowSpan),
      child: data.dec(_f$child),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GridPlacementNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GridPlacementNode>(map);
  }

  static GridPlacementNode fromJson(String json) {
    return ensureInitialized().decodeJson<GridPlacementNode>(json);
  }
}

mixin GridPlacementNodeMappable {
  String toJson() {
    return GridPlacementNodeMapper.ensureInitialized()
        .encodeJson<GridPlacementNode>(this as GridPlacementNode);
  }

  Map<String, dynamic> toMap() {
    return GridPlacementNodeMapper.ensureInitialized()
        .encodeMap<GridPlacementNode>(this as GridPlacementNode);
  }

  GridPlacementNodeCopyWith<
    GridPlacementNode,
    GridPlacementNode,
    GridPlacementNode
  >
  get copyWith =>
      _GridPlacementNodeCopyWithImpl<GridPlacementNode, GridPlacementNode>(
        this as GridPlacementNode,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GridPlacementNodeMapper.ensureInitialized().stringifyValue(
      this as GridPlacementNode,
    );
  }

  @override
  bool operator ==(Object other) {
    return GridPlacementNodeMapper.ensureInitialized().equalsValue(
      this as GridPlacementNode,
      other,
    );
  }

  @override
  int get hashCode {
    return GridPlacementNodeMapper.ensureInitialized().hashValue(
      this as GridPlacementNode,
    );
  }
}

extension GridPlacementNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GridPlacementNode, $Out> {
  GridPlacementNodeCopyWith<$R, GridPlacementNode, $Out>
  get $asGridPlacementNode => $base.as(
    (v, t, t2) => _GridPlacementNodeCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GridPlacementNodeCopyWith<
  $R,
  $In extends GridPlacementNode,
  $Out
>
    implements SNodeCopyWith<$R, $In, $Out> {
  SNodeCopyWith<$R, SNode, SNode>? get child;
  @override
  $R call({
    String? name,
    int? columnStart,
    int? columnSpan,
    int? rowStart,
    int? rowSpan,
    SNode? child,
  });
  GridPlacementNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GridPlacementNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GridPlacementNode, $Out>
    implements GridPlacementNodeCopyWith<$R, GridPlacementNode, $Out> {
  _GridPlacementNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GridPlacementNode> $mapper =
      GridPlacementNodeMapper.ensureInitialized();
  @override
  SNodeCopyWith<$R, SNode, SNode>? get child =>
      $value.child?.copyWith.$chain((v) => call(child: v));
  @override
  $R call({
    Object? name = $none,
    Object? columnStart = $none,
    Object? columnSpan = $none,
    Object? rowStart = $none,
    Object? rowSpan = $none,
    Object? child = $none,
  }) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (columnStart != $none) #columnStart: columnStart,
      if (columnSpan != $none) #columnSpan: columnSpan,
      if (rowStart != $none) #rowStart: rowStart,
      if (rowSpan != $none) #rowSpan: rowSpan,
      if (child != $none) #child: child,
    }),
  );
  @override
  GridPlacementNode $make(CopyWithData data) => GridPlacementNode(
    name: data.get(#name, or: $value.name),
    columnStart: data.get(#columnStart, or: $value.columnStart),
    columnSpan: data.get(#columnSpan, or: $value.columnSpan),
    rowStart: data.get(#rowStart, or: $value.rowStart),
    rowSpan: data.get(#rowSpan, or: $value.rowSpan),
    child: data.get(#child, or: $value.child),
  );

  @override
  GridPlacementNodeCopyWith<$R2, GridPlacementNode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GridPlacementNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

