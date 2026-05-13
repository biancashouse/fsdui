// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'crossword_node.dart';

class CrosswordNodeMapper extends SubClassMapperBase<CrosswordNode> {
  CrosswordNodeMapper._();

  static CrosswordNodeMapper? _instance;
  static CrosswordNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CrosswordNodeMapper._());
      CLMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'CrosswordNode';

  static String? _$name(CrosswordNode v) => v.name;
  static const Field<CrosswordNode, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$type(CrosswordNode v) => v.type;
  static const Field<CrosswordNode, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
  );
  static String? _$jsonData(CrosswordNode v) => v.jsonData;
  static const Field<CrosswordNode, String> _f$jsonData = Field(
    'jsonData',
    _$jsonData,
    opt: true,
  );
  static String _$uid(CrosswordNode v) => v.uid;
  static const Field<CrosswordNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(CrosswordNode v) => v.tags;
  static const Field<CrosswordNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(CrosswordNode v) =>
      v.treeNodeGK;
  static const Field<CrosswordNode, GlobalKey<State<StatefulWidget>>>
  _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(CrosswordNode v) => v.isExpanded;
  static const Field<CrosswordNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(CrosswordNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<CrosswordNode, bool> _f$hidePropertiesWhileDragging =
      Field(
        'hidePropertiesWhileDragging',
        _$hidePropertiesWhileDragging,
        mode: FieldMode.member,
      );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(CrosswordNode v) =>
      v.nodeGK;
  static const Field<CrosswordNode, GlobalKey<State<StatefulWidget>>>
  _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<CrosswordNode> fields = const {
    #name: _f$name,
    #type: _f$type,
    #jsonData: _f$jsonData,
    #uid: _f$uid,
    #tags: _f$tags,
    #treeNodeGK: _f$treeNodeGK,
    #isExpanded: _f$isExpanded,
    #hidePropertiesWhileDragging: _f$hidePropertiesWhileDragging,
    #nodeGK: _f$nodeGK,
  };

  @override
  final String discriminatorKey = 'DK:cl';
  @override
  final dynamic discriminatorValue = 'CrosswordNode';
  @override
  late final ClassMapperBase superMapper = CLMapper.ensureInitialized();

  @override
  final MappingHook superHook = ChainedHook([
    PropertyRenameHook('cl', 'DK:cl'),
    PropertyRenameHook('snode', 'DK:snode'),
  ]);

  static CrosswordNode _instantiate(DecodingData data) {
    return CrosswordNode(
      name: data.dec(_f$name),
      type: data.dec(_f$type),
      jsonData: data.dec(_f$jsonData),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CrosswordNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CrosswordNode>(map);
  }

  static CrosswordNode fromJson(String json) {
    return ensureInitialized().decodeJson<CrosswordNode>(json);
  }
}

mixin CrosswordNodeMappable {
  String toJson() {
    return CrosswordNodeMapper.ensureInitialized().encodeJson<CrosswordNode>(
      this as CrosswordNode,
    );
  }

  Map<String, dynamic> toMap() {
    return CrosswordNodeMapper.ensureInitialized().encodeMap<CrosswordNode>(
      this as CrosswordNode,
    );
  }

  CrosswordNodeCopyWith<CrosswordNode, CrosswordNode, CrosswordNode>
  get copyWith => _CrosswordNodeCopyWithImpl<CrosswordNode, CrosswordNode>(
    this as CrosswordNode,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CrosswordNodeMapper.ensureInitialized().stringifyValue(
      this as CrosswordNode,
    );
  }

  @override
  bool operator ==(Object other) {
    return CrosswordNodeMapper.ensureInitialized().equalsValue(
      this as CrosswordNode,
      other,
    );
  }

  @override
  int get hashCode {
    return CrosswordNodeMapper.ensureInitialized().hashValue(
      this as CrosswordNode,
    );
  }
}

extension CrosswordNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CrosswordNode, $Out> {
  CrosswordNodeCopyWith<$R, CrosswordNode, $Out> get $asCrosswordNode =>
      $base.as((v, t, t2) => _CrosswordNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CrosswordNodeCopyWith<$R, $In extends CrosswordNode, $Out>
    implements CLCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? type, String? jsonData});
  CrosswordNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CrosswordNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CrosswordNode, $Out>
    implements CrosswordNodeCopyWith<$R, CrosswordNode, $Out> {
  _CrosswordNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CrosswordNode> $mapper =
      CrosswordNodeMapper.ensureInitialized();
  @override
  $R call({
    Object? name = $none,
    Object? type = $none,
    Object? jsonData = $none,
  }) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (type != $none) #type: type,
      if (jsonData != $none) #jsonData: jsonData,
    }),
  );
  @override
  CrosswordNode $make(CopyWithData data) => CrosswordNode(
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
    jsonData: data.get(#jsonData, or: $value.jsonData),
  );

  @override
  CrosswordNodeCopyWith<$R2, CrosswordNode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CrosswordNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

