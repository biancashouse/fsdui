// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'named_widget_node.dart';

class NamedWidgetNodeMapper extends SubClassMapperBase<NamedWidgetNode> {
  NamedWidgetNodeMapper._();

  static NamedWidgetNodeMapper? _instance;
  static NamedWidgetNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NamedWidgetNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'NamedWidgetNode';

  static String? _$name(NamedWidgetNode v) => v.name;
  static const Field<NamedWidgetNode, String> _f$name =
      Field('name', _$name, opt: true);
  static String? _$widgetName(NamedWidgetNode v) => v.widgetName;
  static const Field<NamedWidgetNode, String> _f$widgetName =
      Field('widgetName', _$widgetName, opt: true);
  static String _$uid(NamedWidgetNode v) => v.uid;
  static const Field<NamedWidgetNode, String> _f$uid =
      Field('uid', _$uid, mode: FieldMode.member);
  static List<String>? _$tags(NamedWidgetNode v) => v.tags;
  static const Field<NamedWidgetNode, List<String>> _f$tags =
      Field('tags', _$tags, mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(NamedWidgetNode v) =>
      v.treeNodeGK;
  static const Field<NamedWidgetNode, GlobalKey<State<StatefulWidget>>>
      _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(NamedWidgetNode v) => v.isExpanded;
  static const Field<NamedWidgetNode, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, mode: FieldMode.member);
  static bool? _$hidePropertiesWhileDragging(NamedWidgetNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<NamedWidgetNode, bool> _f$hidePropertiesWhileDragging =
      Field('hidePropertiesWhileDragging', _$hidePropertiesWhileDragging,
          mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(NamedWidgetNode v) =>
      v.nodeGK;
  static const Field<NamedWidgetNode, GlobalKey<State<StatefulWidget>>>
      _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<NamedWidgetNode> fields = const {
    #name: _f$name,
    #widgetName: _f$widgetName,
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
  final dynamic discriminatorValue = 'NamedWidgetNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static NamedWidgetNode _instantiate(DecodingData data) {
    return NamedWidgetNode(
        name: data.dec(_f$name), widgetName: data.dec(_f$widgetName));
  }

  @override
  final Function instantiate = _instantiate;

  static NamedWidgetNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NamedWidgetNode>(map);
  }

  static NamedWidgetNode fromJson(String json) {
    return ensureInitialized().decodeJson<NamedWidgetNode>(json);
  }
}

mixin NamedWidgetNodeMappable {
  String toJson() {
    return NamedWidgetNodeMapper.ensureInitialized()
        .encodeJson<NamedWidgetNode>(this as NamedWidgetNode);
  }

  Map<String, dynamic> toMap() {
    return NamedWidgetNodeMapper.ensureInitialized()
        .encodeMap<NamedWidgetNode>(this as NamedWidgetNode);
  }

  NamedWidgetNodeCopyWith<NamedWidgetNode, NamedWidgetNode, NamedWidgetNode>
      get copyWith =>
          _NamedWidgetNodeCopyWithImpl<NamedWidgetNode, NamedWidgetNode>(
              this as NamedWidgetNode, $identity, $identity);
  @override
  String toString() {
    return NamedWidgetNodeMapper.ensureInitialized()
        .stringifyValue(this as NamedWidgetNode);
  }

  @override
  bool operator ==(Object other) {
    return NamedWidgetNodeMapper.ensureInitialized()
        .equalsValue(this as NamedWidgetNode, other);
  }

  @override
  int get hashCode {
    return NamedWidgetNodeMapper.ensureInitialized()
        .hashValue(this as NamedWidgetNode);
  }
}

extension NamedWidgetNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NamedWidgetNode, $Out> {
  NamedWidgetNodeCopyWith<$R, NamedWidgetNode, $Out> get $asNamedWidgetNode =>
      $base.as((v, t, t2) => _NamedWidgetNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NamedWidgetNodeCopyWith<$R, $In extends NamedWidgetNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? widgetName});
  NamedWidgetNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NamedWidgetNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NamedWidgetNode, $Out>
    implements NamedWidgetNodeCopyWith<$R, NamedWidgetNode, $Out> {
  _NamedWidgetNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NamedWidgetNode> $mapper =
      NamedWidgetNodeMapper.ensureInitialized();
  @override
  $R call({Object? name = $none, Object? widgetName = $none}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (widgetName != $none) #widgetName: widgetName
      }));
  @override
  NamedWidgetNode $make(CopyWithData data) => NamedWidgetNode(
      name: data.get(#name, or: $value.name),
      widgetName: data.get(#widgetName, or: $value.widgetName));

  @override
  NamedWidgetNodeCopyWith<$R2, NamedWidgetNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NamedWidgetNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
