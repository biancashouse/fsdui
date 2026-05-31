// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'article_listview_node.dart';

class ArticleListViewNodeMapper
    extends SubClassMapperBase<ArticleListViewNode> {
  ArticleListViewNodeMapper._();

  static ArticleListViewNodeMapper? _instance;
  static ArticleListViewNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArticleListViewNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      AxisEnumMapper.ensureInitialized();
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ArticleListViewNode';

  static String? _$name(ArticleListViewNode v) => v.name;
  static const Field<ArticleListViewNode, String> _f$name =
      Field('name', _$name, opt: true);
  static AxisEnum _$scrollDirection(ArticleListViewNode v) => v.scrollDirection;
  static const Field<ArticleListViewNode, AxisEnum> _f$scrollDirection = Field(
      'scrollDirection', _$scrollDirection,
      opt: true, def: AxisEnum.vertical);
  static bool? _$shrinkWrap(ArticleListViewNode v) => v.shrinkWrap;
  static const Field<ArticleListViewNode, bool> _f$shrinkWrap =
      Field('shrinkWrap', _$shrinkWrap, opt: true);
  static EdgeInsets? _$padding(ArticleListViewNode v) => v.padding;
  static const Field<ArticleListViewNode, EdgeInsets> _f$padding =
      Field('padding', _$padding, opt: true);
  static List<SNode> _$children(ArticleListViewNode v) => v.children;
  static const Field<ArticleListViewNode, List<SNode>> _f$children =
      Field('children', _$children);
  static String _$uid(ArticleListViewNode v) => v.uid;
  static const Field<ArticleListViewNode, String> _f$uid =
      Field('uid', _$uid, mode: FieldMode.member);
  static List<String>? _$tags(ArticleListViewNode v) => v.tags;
  static const Field<ArticleListViewNode, List<String>> _f$tags =
      Field('tags', _$tags, mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(
          ArticleListViewNode v) =>
      v.treeNodeGK;
  static const Field<ArticleListViewNode, GlobalKey<State<StatefulWidget>>>
      _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(ArticleListViewNode v) => v.isExpanded;
  static const Field<ArticleListViewNode, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, mode: FieldMode.member);
  static bool? _$hidePropertiesWhileDragging(ArticleListViewNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<ArticleListViewNode, bool> _f$hidePropertiesWhileDragging =
      Field('hidePropertiesWhileDragging', _$hidePropertiesWhileDragging,
          mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(ArticleListViewNode v) =>
      v.nodeGK;
  static const Field<ArticleListViewNode, GlobalKey<State<StatefulWidget>>>
      _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<ArticleListViewNode> fields = const {
    #name: _f$name,
    #scrollDirection: _f$scrollDirection,
    #shrinkWrap: _f$shrinkWrap,
    #padding: _f$padding,
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
  final dynamic discriminatorValue = 'ArticleListViewNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static ArticleListViewNode _instantiate(DecodingData data) {
    return ArticleListViewNode(
        name: data.dec(_f$name),
        scrollDirection: data.dec(_f$scrollDirection),
        shrinkWrap: data.dec(_f$shrinkWrap),
        padding: data.dec(_f$padding),
        children: data.dec(_f$children));
  }

  @override
  final Function instantiate = _instantiate;

  static ArticleListViewNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ArticleListViewNode>(map);
  }

  static ArticleListViewNode fromJson(String json) {
    return ensureInitialized().decodeJson<ArticleListViewNode>(json);
  }
}

mixin ArticleListViewNodeMappable {
  String toJson() {
    return ArticleListViewNodeMapper.ensureInitialized()
        .encodeJson<ArticleListViewNode>(this as ArticleListViewNode);
  }

  Map<String, dynamic> toMap() {
    return ArticleListViewNodeMapper.ensureInitialized()
        .encodeMap<ArticleListViewNode>(this as ArticleListViewNode);
  }

  ArticleListViewNodeCopyWith<ArticleListViewNode, ArticleListViewNode,
      ArticleListViewNode> get copyWith => _ArticleListViewNodeCopyWithImpl<
          ArticleListViewNode, ArticleListViewNode>(
      this as ArticleListViewNode, $identity, $identity);
  @override
  String toString() {
    return ArticleListViewNodeMapper.ensureInitialized()
        .stringifyValue(this as ArticleListViewNode);
  }

  @override
  bool operator ==(Object other) {
    return ArticleListViewNodeMapper.ensureInitialized()
        .equalsValue(this as ArticleListViewNode, other);
  }

  @override
  int get hashCode {
    return ArticleListViewNodeMapper.ensureInitialized()
        .hashValue(this as ArticleListViewNode);
  }
}

extension ArticleListViewNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ArticleListViewNode, $Out> {
  ArticleListViewNodeCopyWith<$R, ArticleListViewNode, $Out>
      get $asArticleListViewNode => $base.as(
          (v, t, t2) => _ArticleListViewNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ArticleListViewNodeCopyWith<$R, $In extends ArticleListViewNode,
    $Out> implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call(
      {String? name,
      AxisEnum? scrollDirection,
      bool? shrinkWrap,
      EdgeInsets? padding,
      List<SNode>? children});
  ArticleListViewNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ArticleListViewNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ArticleListViewNode, $Out>
    implements ArticleListViewNodeCopyWith<$R, ArticleListViewNode, $Out> {
  _ArticleListViewNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ArticleListViewNode> $mapper =
      ArticleListViewNodeMapper.ensureInitialized();
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
          List<SNode>? children}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (scrollDirection != null) #scrollDirection: scrollDirection,
        if (shrinkWrap != $none) #shrinkWrap: shrinkWrap,
        if (padding != $none) #padding: padding,
        if (children != null) #children: children
      }));
  @override
  ArticleListViewNode $make(CopyWithData data) => ArticleListViewNode(
      name: data.get(#name, or: $value.name),
      scrollDirection: data.get(#scrollDirection, or: $value.scrollDirection),
      shrinkWrap: data.get(#shrinkWrap, or: $value.shrinkWrap),
      padding: data.get(#padding, or: $value.padding),
      children: data.get(#children, or: $value.children));

  @override
  ArticleListViewNodeCopyWith<$R2, ArticleListViewNode, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ArticleListViewNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
