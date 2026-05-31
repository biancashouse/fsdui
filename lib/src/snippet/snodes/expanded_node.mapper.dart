// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'expanded_node.dart';

class ExpandedNodeMapper extends SubClassMapperBase<ExpandedNode> {
  ExpandedNodeMapper._();

  static ExpandedNodeMapper? _instance;
  static ExpandedNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExpandedNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      FlexFitEnumMapper.ensureInitialized();
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExpandedNode';

  static String? _$name(ExpandedNode v) => v.name;
  static const Field<ExpandedNode, String> _f$name =
      Field('name', _$name, opt: true);
  static int _$flex(ExpandedNode v) => v.flex;
  static const Field<ExpandedNode, int> _f$flex =
      Field('flex', _$flex, opt: true, def: 1);
  static FlexFitEnum _$fit(ExpandedNode v) => v.fit;
  static const Field<ExpandedNode, FlexFitEnum> _f$fit =
      Field('fit', _$fit, opt: true, def: FlexFitEnum.loose);
  static SNode? _$child(ExpandedNode v) => v.child;
  static const Field<ExpandedNode, SNode> _f$child =
      Field('child', _$child, opt: true);
  static String _$uid(ExpandedNode v) => v.uid;
  static const Field<ExpandedNode, String> _f$uid =
      Field('uid', _$uid, mode: FieldMode.member);
  static List<String>? _$tags(ExpandedNode v) => v.tags;
  static const Field<ExpandedNode, List<String>> _f$tags =
      Field('tags', _$tags, mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(ExpandedNode v) =>
      v.treeNodeGK;
  static const Field<ExpandedNode, GlobalKey<State<StatefulWidget>>>
      _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(ExpandedNode v) => v.isExpanded;
  static const Field<ExpandedNode, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, mode: FieldMode.member);
  static bool? _$hidePropertiesWhileDragging(ExpandedNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<ExpandedNode, bool> _f$hidePropertiesWhileDragging = Field(
      'hidePropertiesWhileDragging', _$hidePropertiesWhileDragging,
      mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(ExpandedNode v) => v.nodeGK;
  static const Field<ExpandedNode, GlobalKey<State<StatefulWidget>>> _f$nodeGK =
      Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<ExpandedNode> fields = const {
    #name: _f$name,
    #flex: _f$flex,
    #fit: _f$fit,
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
  final dynamic discriminatorValue = 'ExpandedNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook hook = const PropertyDiscriminatorFixHook();
  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static ExpandedNode _instantiate(DecodingData data) {
    return ExpandedNode(
        name: data.dec(_f$name),
        flex: data.dec(_f$flex),
        fit: data.dec(_f$fit),
        child: data.dec(_f$child));
  }

  @override
  final Function instantiate = _instantiate;

  static ExpandedNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExpandedNode>(map);
  }

  static ExpandedNode fromJson(String json) {
    return ensureInitialized().decodeJson<ExpandedNode>(json);
  }
}

mixin ExpandedNodeMappable {
  String toJson() {
    return ExpandedNodeMapper.ensureInitialized()
        .encodeJson<ExpandedNode>(this as ExpandedNode);
  }

  Map<String, dynamic> toMap() {
    return ExpandedNodeMapper.ensureInitialized()
        .encodeMap<ExpandedNode>(this as ExpandedNode);
  }

  ExpandedNodeCopyWith<ExpandedNode, ExpandedNode, ExpandedNode> get copyWith =>
      _ExpandedNodeCopyWithImpl<ExpandedNode, ExpandedNode>(
          this as ExpandedNode, $identity, $identity);
  @override
  String toString() {
    return ExpandedNodeMapper.ensureInitialized()
        .stringifyValue(this as ExpandedNode);
  }

  @override
  bool operator ==(Object other) {
    return ExpandedNodeMapper.ensureInitialized()
        .equalsValue(this as ExpandedNode, other);
  }

  @override
  int get hashCode {
    return ExpandedNodeMapper.ensureInitialized()
        .hashValue(this as ExpandedNode);
  }
}

extension ExpandedNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExpandedNode, $Out> {
  ExpandedNodeCopyWith<$R, ExpandedNode, $Out> get $asExpandedNode =>
      $base.as((v, t, t2) => _ExpandedNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ExpandedNodeCopyWith<$R, $In extends ExpandedNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  SNodeCopyWith<$R, SNode, SNode>? get child;
  @override
  $R call({String? name, int? flex, FlexFitEnum? fit, SNode? child});
  ExpandedNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExpandedNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExpandedNode, $Out>
    implements ExpandedNodeCopyWith<$R, ExpandedNode, $Out> {
  _ExpandedNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExpandedNode> $mapper =
      ExpandedNodeMapper.ensureInitialized();
  @override
  SNodeCopyWith<$R, SNode, SNode>? get child =>
      $value.child?.copyWith.$chain((v) => call(child: v));
  @override
  $R call(
          {Object? name = $none,
          int? flex,
          FlexFitEnum? fit,
          Object? child = $none}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (flex != null) #flex: flex,
        if (fit != null) #fit: fit,
        if (child != $none) #child: child
      }));
  @override
  ExpandedNode $make(CopyWithData data) => ExpandedNode(
      name: data.get(#name, or: $value.name),
      flex: data.get(#flex, or: $value.flex),
      fit: data.get(#fit, or: $value.fit),
      child: data.get(#child, or: $value.child));

  @override
  ExpandedNodeCopyWith<$R2, ExpandedNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ExpandedNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
