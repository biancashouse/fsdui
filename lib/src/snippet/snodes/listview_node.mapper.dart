// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'listview_node.dart';

class ListViewNodeMapper extends SubClassMapperBase<ListViewNode> {
  ListViewNodeMapper._();

  static ListViewNodeMapper? _instance;
  static ListViewNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ListViewNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      AxisEnumMapper.ensureInitialized();
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ListViewNode';

  static String? _$name(ListViewNode v) => v.name;
  static const Field<ListViewNode, String> _f$name =
      Field('name', _$name, opt: true);
  static AxisEnum _$scrollDirection(ListViewNode v) => v.scrollDirection;
  static const Field<ListViewNode, AxisEnum> _f$scrollDirection = Field(
      'scrollDirection', _$scrollDirection,
      opt: true, def: AxisEnum.vertical);
  static bool? _$shrinkWrap(ListViewNode v) => v.shrinkWrap;
  static const Field<ListViewNode, bool> _f$shrinkWrap =
      Field('shrinkWrap', _$shrinkWrap, opt: true);
  static EdgeInsets? _$padding(ListViewNode v) => v.padding;
  static const Field<ListViewNode, EdgeInsets> _f$padding =
      Field('padding', _$padding, opt: true);
  static List<SNode> _$children(ListViewNode v) => v.children;
  static const Field<ListViewNode, List<SNode>> _f$children =
      Field('children', _$children);
  static String _$uid(ListViewNode v) => v.uid;
  static const Field<ListViewNode, String> _f$uid =
      Field('uid', _$uid, mode: FieldMode.member);
  static List<String>? _$tags(ListViewNode v) => v.tags;
  static const Field<ListViewNode, List<String>> _f$tags =
      Field('tags', _$tags, mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(ListViewNode v) =>
      v.treeNodeGK;
  static const Field<ListViewNode, GlobalKey<State<StatefulWidget>>>
      _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(ListViewNode v) => v.isExpanded;
  static const Field<ListViewNode, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, mode: FieldMode.member);
  static bool? _$hidePropertiesWhileDragging(ListViewNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<ListViewNode, bool> _f$hidePropertiesWhileDragging = Field(
      'hidePropertiesWhileDragging', _$hidePropertiesWhileDragging,
      mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(ListViewNode v) => v.nodeGK;
  static const Field<ListViewNode, GlobalKey<State<StatefulWidget>>> _f$nodeGK =
      Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<ListViewNode> fields = const {
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
  final dynamic discriminatorValue = 'ListViewNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static ListViewNode _instantiate(DecodingData data) {
    return ListViewNode(
        name: data.dec(_f$name),
        scrollDirection: data.dec(_f$scrollDirection),
        shrinkWrap: data.dec(_f$shrinkWrap),
        padding: data.dec(_f$padding),
        children: data.dec(_f$children));
  }

  @override
  final Function instantiate = _instantiate;

  static ListViewNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ListViewNode>(map);
  }

  static ListViewNode fromJson(String json) {
    return ensureInitialized().decodeJson<ListViewNode>(json);
  }
}

mixin ListViewNodeMappable {
  String toJson() {
    return ListViewNodeMapper.ensureInitialized()
        .encodeJson<ListViewNode>(this as ListViewNode);
  }

  Map<String, dynamic> toMap() {
    return ListViewNodeMapper.ensureInitialized()
        .encodeMap<ListViewNode>(this as ListViewNode);
  }

  ListViewNodeCopyWith<ListViewNode, ListViewNode, ListViewNode> get copyWith =>
      _ListViewNodeCopyWithImpl<ListViewNode, ListViewNode>(
          this as ListViewNode, $identity, $identity);
  @override
  String toString() {
    return ListViewNodeMapper.ensureInitialized()
        .stringifyValue(this as ListViewNode);
  }

  @override
  bool operator ==(Object other) {
    return ListViewNodeMapper.ensureInitialized()
        .equalsValue(this as ListViewNode, other);
  }

  @override
  int get hashCode {
    return ListViewNodeMapper.ensureInitialized()
        .hashValue(this as ListViewNode);
  }
}

extension ListViewNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ListViewNode, $Out> {
  ListViewNodeCopyWith<$R, ListViewNode, $Out> get $asListViewNode =>
      $base.as((v, t, t2) => _ListViewNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ListViewNodeCopyWith<$R, $In extends ListViewNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call(
      {String? name,
      AxisEnum? scrollDirection,
      bool? shrinkWrap,
      EdgeInsets? padding,
      List<SNode>? children});
  ListViewNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ListViewNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ListViewNode, $Out>
    implements ListViewNodeCopyWith<$R, ListViewNode, $Out> {
  _ListViewNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ListViewNode> $mapper =
      ListViewNodeMapper.ensureInitialized();
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
  ListViewNode $make(CopyWithData data) => ListViewNode(
      name: data.get(#name, or: $value.name),
      scrollDirection: data.get(#scrollDirection, or: $value.scrollDirection),
      shrinkWrap: data.get(#shrinkWrap, or: $value.shrinkWrap),
      padding: data.get(#padding, or: $value.padding),
      children: data.get(#children, or: $value.children));

  @override
  ListViewNodeCopyWith<$R2, ListViewNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ListViewNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
