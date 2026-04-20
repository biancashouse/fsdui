// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'yt_node.dart';

class YTNodeMapper extends SubClassMapperBase<YTNode> {
  YTNodeMapper._();

  static YTNodeMapper? _instance;
  static YTNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = YTNodeMapper._());
      CLMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'YTNode';

  static String? _$name(YTNode v) => v.name;
  static const Field<YTNode, String> _f$name = Field('name', _$name, opt: true);
  static String _$ytEmbedHtml(YTNode v) => v.ytEmbedHtml;
  static const Field<YTNode, String> _f$ytEmbedHtml = Field(
    'ytEmbedHtml',
    _$ytEmbedHtml,
    opt: true,
    def:
        '<iframe width="560" height="315" src="https://www.youtube.com/embed/u1FAoLEG16c?si=YN1UucqLyPLntjYJ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
  );
  static double _$scale(YTNode v) => v.scale;
  static const Field<YTNode, double> _f$scale = Field(
    'scale',
    _$scale,
    opt: true,
    def: 1.0,
  );
  static String _$uid(YTNode v) => v.uid;
  static const Field<YTNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(YTNode v) => v.tags;
  static const Field<YTNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(YTNode v) =>
      v.treeNodeGK;
  static const Field<YTNode, GlobalKey<State<StatefulWidget>>> _f$treeNodeGK =
      Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(YTNode v) => v.isExpanded;
  static const Field<YTNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(YTNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<YTNode, bool> _f$hidePropertiesWhileDragging = Field(
    'hidePropertiesWhileDragging',
    _$hidePropertiesWhileDragging,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(YTNode v) => v.nodeGK;
  static const Field<YTNode, GlobalKey<State<StatefulWidget>>> _f$nodeGK =
      Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<YTNode> fields = const {
    #name: _f$name,
    #ytEmbedHtml: _f$ytEmbedHtml,
    #scale: _f$scale,
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
  final dynamic discriminatorValue = 'YTNode';
  @override
  late final ClassMapperBase superMapper = CLMapper.ensureInitialized();

  @override
  final MappingHook superHook = ChainedHook([
    PropertyRenameHook('cl', 'DK:cl'),
    PropertyRenameHook('snode', 'DK:snode'),
  ]);

  static YTNode _instantiate(DecodingData data) {
    return YTNode(
      name: data.dec(_f$name),
      ytEmbedHtml: data.dec(_f$ytEmbedHtml),
      scale: data.dec(_f$scale),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static YTNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<YTNode>(map);
  }

  static YTNode fromJson(String json) {
    return ensureInitialized().decodeJson<YTNode>(json);
  }
}

mixin YTNodeMappable {
  String toJson() {
    return YTNodeMapper.ensureInitialized().encodeJson<YTNode>(this as YTNode);
  }

  Map<String, dynamic> toMap() {
    return YTNodeMapper.ensureInitialized().encodeMap<YTNode>(this as YTNode);
  }

  YTNodeCopyWith<YTNode, YTNode, YTNode> get copyWith =>
      _YTNodeCopyWithImpl<YTNode, YTNode>(this as YTNode, $identity, $identity);
  @override
  String toString() {
    return YTNodeMapper.ensureInitialized().stringifyValue(this as YTNode);
  }

  @override
  bool operator ==(Object other) {
    return YTNodeMapper.ensureInitialized().equalsValue(this as YTNode, other);
  }

  @override
  int get hashCode {
    return YTNodeMapper.ensureInitialized().hashValue(this as YTNode);
  }
}

extension YTNodeValueCopy<$R, $Out> on ObjectCopyWith<$R, YTNode, $Out> {
  YTNodeCopyWith<$R, YTNode, $Out> get $asYTNode =>
      $base.as((v, t, t2) => _YTNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class YTNodeCopyWith<$R, $In extends YTNode, $Out>
    implements CLCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? ytEmbedHtml, double? scale});
  YTNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _YTNodeCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, YTNode, $Out>
    implements YTNodeCopyWith<$R, YTNode, $Out> {
  _YTNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<YTNode> $mapper = YTNodeMapper.ensureInitialized();
  @override
  $R call({Object? name = $none, String? ytEmbedHtml, double? scale}) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (ytEmbedHtml != null) #ytEmbedHtml: ytEmbedHtml,
      if (scale != null) #scale: scale,
    }),
  );
  @override
  YTNode $make(CopyWithData data) => YTNode(
    name: data.get(#name, or: $value.name),
    ytEmbedHtml: data.get(#ytEmbedHtml, or: $value.ytEmbedHtml),
    scale: data.get(#scale, or: $value.scale),
  );

  @override
  YTNodeCopyWith<$R2, YTNode, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _YTNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

