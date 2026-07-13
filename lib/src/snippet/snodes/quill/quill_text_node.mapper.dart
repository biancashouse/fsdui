// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'quill_text_node.dart';

class QuillTextNodeMapper extends SubClassMapperBase<QuillTextNode> {
  QuillTextNodeMapper._();

  static QuillTextNodeMapper? _instance;
  static QuillTextNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QuillTextNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'QuillTextNode';

  static String? _$name(QuillTextNode v) => v.name;
  static const Field<QuillTextNode, String> _f$name =
      Field('name', _$name, opt: true);
  static String _$deltaJsonString(QuillTextNode v) => v.deltaJsonString;
  static const Field<QuillTextNode, String> _f$deltaJsonString = Field(
      'deltaJsonString', _$deltaJsonString,
      opt: true, def: k_emptyDeltaJsonString);
  static double _$h1BottomGap(QuillTextNode v) => v.h1BottomGap;
  static const Field<QuillTextNode, double> _f$h1BottomGap =
      Field('h1BottomGap', _$h1BottomGap, opt: true, def: 16.0);
  static double _$h2BottomGap(QuillTextNode v) => v.h2BottomGap;
  static const Field<QuillTextNode, double> _f$h2BottomGap =
      Field('h2BottomGap', _$h2BottomGap, opt: true, def: 12.0);
  static double _$h3BottomGap(QuillTextNode v) => v.h3BottomGap;
  static const Field<QuillTextNode, double> _f$h3BottomGap =
      Field('h3BottomGap', _$h3BottomGap, opt: true, def: 8.0);
  static double _$listItemGap(QuillTextNode v) => v.listItemGap;
  static const Field<QuillTextNode, double> _f$listItemGap =
      Field('listItemGap', _$listItemGap, opt: true, def: 8.0);
  static double _$paragraphBottomGap(QuillTextNode v) => v.paragraphBottomGap;
  static const Field<QuillTextNode, double> _f$paragraphBottomGap =
      Field('paragraphBottomGap', _$paragraphBottomGap, opt: true, def: 16.0);
  static String _$uid(QuillTextNode v) => v.uid;
  static const Field<QuillTextNode, String> _f$uid =
      Field('uid', _$uid, mode: FieldMode.member);
  static List<String>? _$tags(QuillTextNode v) => v.tags;
  static const Field<QuillTextNode, List<String>> _f$tags =
      Field('tags', _$tags, mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(QuillTextNode v) =>
      v.treeNodeGK;
  static const Field<QuillTextNode, GlobalKey<State<StatefulWidget>>>
      _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(QuillTextNode v) => v.isExpanded;
  static const Field<QuillTextNode, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, mode: FieldMode.member);
  static bool? _$hidePropertiesWhileDragging(QuillTextNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<QuillTextNode, bool> _f$hidePropertiesWhileDragging =
      Field('hidePropertiesWhileDragging', _$hidePropertiesWhileDragging,
          mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(QuillTextNode v) =>
      v.nodeGK;
  static const Field<QuillTextNode, GlobalKey<State<StatefulWidget>>>
      _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<QuillTextNode> fields = const {
    #name: _f$name,
    #deltaJsonString: _f$deltaJsonString,
    #h1BottomGap: _f$h1BottomGap,
    #h2BottomGap: _f$h2BottomGap,
    #h3BottomGap: _f$h3BottomGap,
    #listItemGap: _f$listItemGap,
    #paragraphBottomGap: _f$paragraphBottomGap,
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
  final dynamic discriminatorValue = 'QuillTextNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static QuillTextNode _instantiate(DecodingData data) {
    return QuillTextNode(
        name: data.dec(_f$name),
        deltaJsonString: data.dec(_f$deltaJsonString),
        h1BottomGap: data.dec(_f$h1BottomGap),
        h2BottomGap: data.dec(_f$h2BottomGap),
        h3BottomGap: data.dec(_f$h3BottomGap),
        listItemGap: data.dec(_f$listItemGap),
        paragraphBottomGap: data.dec(_f$paragraphBottomGap));
  }

  @override
  final Function instantiate = _instantiate;

  static QuillTextNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<QuillTextNode>(map);
  }

  static QuillTextNode fromJson(String json) {
    return ensureInitialized().decodeJson<QuillTextNode>(json);
  }
}

mixin QuillTextNodeMappable {
  String toJson() {
    return QuillTextNodeMapper.ensureInitialized()
        .encodeJson<QuillTextNode>(this as QuillTextNode);
  }

  Map<String, dynamic> toMap() {
    return QuillTextNodeMapper.ensureInitialized()
        .encodeMap<QuillTextNode>(this as QuillTextNode);
  }

  QuillTextNodeCopyWith<QuillTextNode, QuillTextNode, QuillTextNode>
      get copyWith => _QuillTextNodeCopyWithImpl<QuillTextNode, QuillTextNode>(
          this as QuillTextNode, $identity, $identity);
  @override
  String toString() {
    return QuillTextNodeMapper.ensureInitialized()
        .stringifyValue(this as QuillTextNode);
  }

  @override
  bool operator ==(Object other) {
    return QuillTextNodeMapper.ensureInitialized()
        .equalsValue(this as QuillTextNode, other);
  }

  @override
  int get hashCode {
    return QuillTextNodeMapper.ensureInitialized()
        .hashValue(this as QuillTextNode);
  }
}

extension QuillTextNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, QuillTextNode, $Out> {
  QuillTextNodeCopyWith<$R, QuillTextNode, $Out> get $asQuillTextNode =>
      $base.as((v, t, t2) => _QuillTextNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class QuillTextNodeCopyWith<$R, $In extends QuillTextNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? name,
      String? deltaJsonString,
      double? h1BottomGap,
      double? h2BottomGap,
      double? h3BottomGap,
      double? listItemGap,
      double? paragraphBottomGap});
  QuillTextNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _QuillTextNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, QuillTextNode, $Out>
    implements QuillTextNodeCopyWith<$R, QuillTextNode, $Out> {
  _QuillTextNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<QuillTextNode> $mapper =
      QuillTextNodeMapper.ensureInitialized();
  @override
  $R call(
          {Object? name = $none,
          String? deltaJsonString,
          double? h1BottomGap,
          double? h2BottomGap,
          double? h3BottomGap,
          double? listItemGap,
          double? paragraphBottomGap}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (deltaJsonString != null) #deltaJsonString: deltaJsonString,
        if (h1BottomGap != null) #h1BottomGap: h1BottomGap,
        if (h2BottomGap != null) #h2BottomGap: h2BottomGap,
        if (h3BottomGap != null) #h3BottomGap: h3BottomGap,
        if (listItemGap != null) #listItemGap: listItemGap,
        if (paragraphBottomGap != null) #paragraphBottomGap: paragraphBottomGap
      }));
  @override
  QuillTextNode $make(CopyWithData data) => QuillTextNode(
      name: data.get(#name, or: $value.name),
      deltaJsonString: data.get(#deltaJsonString, or: $value.deltaJsonString),
      h1BottomGap: data.get(#h1BottomGap, or: $value.h1BottomGap),
      h2BottomGap: data.get(#h2BottomGap, or: $value.h2BottomGap),
      h3BottomGap: data.get(#h3BottomGap, or: $value.h3BottomGap),
      listItemGap: data.get(#listItemGap, or: $value.listItemGap),
      paragraphBottomGap:
          data.get(#paragraphBottomGap, or: $value.paragraphBottomGap));

  @override
  QuillTextNodeCopyWith<$R2, QuillTextNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _QuillTextNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
