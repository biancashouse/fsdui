// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pageview_node.dart';

class PageViewNodeMapper extends SubClassMapperBase<PageViewNode> {
  PageViewNodeMapper._();

  static PageViewNodeMapper? _instance;
  static PageViewNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PageViewNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PageViewNode';

  static String? _$name(PageViewNode v) => v.name;
  static const Field<PageViewNode, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static List<String> _$childSnippetNames(PageViewNode v) =>
      v.childSnippetNames;
  static const Field<PageViewNode, List<String>> _f$childSnippetNames = Field(
    'childSnippetNames',
    _$childSnippetNames,
    opt: true,
    def: const [],
  );
  static List<String> _$childSnippetTitles(PageViewNode v) =>
      v.childSnippetTitles;
  static const Field<PageViewNode, List<String>> _f$childSnippetTitles = Field(
    'childSnippetTitles',
    _$childSnippetTitles,
    opt: true,
    def: const [],
  );
  static String _$uid(PageViewNode v) => v.uid;
  static const Field<PageViewNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(PageViewNode v) => v.tags;
  static const Field<PageViewNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(PageViewNode v) =>
      v.treeNodeGK;
  static const Field<PageViewNode, GlobalKey<State<StatefulWidget>>>
  _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(PageViewNode v) => v.isExpanded;
  static const Field<PageViewNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(PageViewNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<PageViewNode, bool> _f$hidePropertiesWhileDragging = Field(
    'hidePropertiesWhileDragging',
    _$hidePropertiesWhileDragging,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(PageViewNode v) => v.nodeGK;
  static const Field<PageViewNode, GlobalKey<State<StatefulWidget>>> _f$nodeGK =
      Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<PageViewNode> fields = const {
    #name: _f$name,
    #childSnippetNames: _f$childSnippetNames,
    #childSnippetTitles: _f$childSnippetTitles,
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
  final dynamic discriminatorValue = 'PageViewNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static PageViewNode _instantiate(DecodingData data) {
    return PageViewNode(
      name: data.dec(_f$name),
      childSnippetNames: data.dec(_f$childSnippetNames),
      childSnippetTitles: data.dec(_f$childSnippetTitles),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PageViewNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PageViewNode>(map);
  }

  static PageViewNode fromJson(String json) {
    return ensureInitialized().decodeJson<PageViewNode>(json);
  }
}

mixin PageViewNodeMappable {
  String toJson() {
    return PageViewNodeMapper.ensureInitialized().encodeJson<PageViewNode>(
      this as PageViewNode,
    );
  }

  Map<String, dynamic> toMap() {
    return PageViewNodeMapper.ensureInitialized().encodeMap<PageViewNode>(
      this as PageViewNode,
    );
  }

  PageViewNodeCopyWith<PageViewNode, PageViewNode, PageViewNode> get copyWith =>
      _PageViewNodeCopyWithImpl<PageViewNode, PageViewNode>(
        this as PageViewNode,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PageViewNodeMapper.ensureInitialized().stringifyValue(
      this as PageViewNode,
    );
  }

  @override
  bool operator ==(Object other) {
    return PageViewNodeMapper.ensureInitialized().equalsValue(
      this as PageViewNode,
      other,
    );
  }

  @override
  int get hashCode {
    return PageViewNodeMapper.ensureInitialized().hashValue(
      this as PageViewNode,
    );
  }
}

extension PageViewNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PageViewNode, $Out> {
  PageViewNodeCopyWith<$R, PageViewNode, $Out> get $asPageViewNode =>
      $base.as((v, t, t2) => _PageViewNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PageViewNodeCopyWith<$R, $In extends PageViewNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get childSnippetNames;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get childSnippetTitles;
  @override
  $R call({
    String? name,
    List<String>? childSnippetNames,
    List<String>? childSnippetTitles,
  });
  PageViewNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PageViewNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PageViewNode, $Out>
    implements PageViewNodeCopyWith<$R, PageViewNode, $Out> {
  _PageViewNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PageViewNode> $mapper =
      PageViewNodeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get childSnippetNames => ListCopyWith(
    $value.childSnippetNames,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(childSnippetNames: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get childSnippetTitles => ListCopyWith(
    $value.childSnippetTitles,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(childSnippetTitles: v),
  );
  @override
  $R call({
    Object? name = $none,
    List<String>? childSnippetNames,
    List<String>? childSnippetTitles,
  }) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (childSnippetNames != null) #childSnippetNames: childSnippetNames,
      if (childSnippetTitles != null) #childSnippetTitles: childSnippetTitles,
    }),
  );
  @override
  PageViewNode $make(CopyWithData data) => PageViewNode(
    name: data.get(#name, or: $value.name),
    childSnippetNames: data.get(
      #childSnippetNames,
      or: $value.childSnippetNames,
    ),
    childSnippetTitles: data.get(
      #childSnippetTitles,
      or: $value.childSnippetTitles,
    ),
  );

  @override
  PageViewNodeCopyWith<$R2, PageViewNode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PageViewNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

