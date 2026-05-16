// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tabdata_node.dart';

class TabDataNodeMapper extends SubClassMapperBase<TabDataNode> {
  TabDataNodeMapper._();

  static TabDataNodeMapper? _instance;
  static TabDataNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TabDataNodeMapper._());
      SCMapper.ensureInitialized().addSubMapper(_instance!);
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TabDataNode';

  static String _$title(TabDataNode v) => v.title;
  static const Field<TabDataNode, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: 'unnamed tab',
  );
  static SNode? _$child(TabDataNode v) => v.child;
  static const Field<TabDataNode, SNode> _f$child = Field(
    'child',
    _$child,
    opt: true,
  );
  static String _$uid(TabDataNode v) => v.uid;
  static const Field<TabDataNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static String? _$name(TabDataNode v) => v.name;
  static const Field<TabDataNode, String> _f$name = Field(
    'name',
    _$name,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(TabDataNode v) => v.tags;
  static const Field<TabDataNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(TabDataNode v) =>
      v.treeNodeGK;
  static const Field<TabDataNode, GlobalKey<State<StatefulWidget>>>
  _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(TabDataNode v) => v.isExpanded;
  static const Field<TabDataNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(TabDataNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<TabDataNode, bool> _f$hidePropertiesWhileDragging = Field(
    'hidePropertiesWhileDragging',
    _$hidePropertiesWhileDragging,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(TabDataNode v) => v.nodeGK;
  static const Field<TabDataNode, GlobalKey<State<StatefulWidget>>> _f$nodeGK =
      Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<TabDataNode> fields = const {
    #title: _f$title,
    #child: _f$child,
    #uid: _f$uid,
    #name: _f$name,
    #tags: _f$tags,
    #treeNodeGK: _f$treeNodeGK,
    #isExpanded: _f$isExpanded,
    #hidePropertiesWhileDragging: _f$hidePropertiesWhileDragging,
    #nodeGK: _f$nodeGK,
  };

  @override
  final String discriminatorKey = 'DK:sc';
  @override
  final dynamic discriminatorValue = 'TabDataNode';
  @override
  late final ClassMapperBase superMapper = SCMapper.ensureInitialized();

  @override
  final MappingHook superHook = ChainedHook([
    PropertyRenameHook('sc', 'DK:sc'),
    PropertyRenameHook('snode', 'DK:snode'),
  ]);

  static TabDataNode _instantiate(DecodingData data) {
    return TabDataNode(title: data.dec(_f$title), child: data.dec(_f$child));
  }

  @override
  final Function instantiate = _instantiate;

  static TabDataNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TabDataNode>(map);
  }

  static TabDataNode fromJson(String json) {
    return ensureInitialized().decodeJson<TabDataNode>(json);
  }
}

mixin TabDataNodeMappable {
  String toJson() {
    return TabDataNodeMapper.ensureInitialized().encodeJson<TabDataNode>(
      this as TabDataNode,
    );
  }

  Map<String, dynamic> toMap() {
    return TabDataNodeMapper.ensureInitialized().encodeMap<TabDataNode>(
      this as TabDataNode,
    );
  }

  TabDataNodeCopyWith<TabDataNode, TabDataNode, TabDataNode> get copyWith =>
      _TabDataNodeCopyWithImpl<TabDataNode, TabDataNode>(
        this as TabDataNode,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TabDataNodeMapper.ensureInitialized().stringifyValue(
      this as TabDataNode,
    );
  }

  @override
  bool operator ==(Object other) {
    return TabDataNodeMapper.ensureInitialized().equalsValue(
      this as TabDataNode,
      other,
    );
  }

  @override
  int get hashCode {
    return TabDataNodeMapper.ensureInitialized().hashValue(this as TabDataNode);
  }
}

extension TabDataNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TabDataNode, $Out> {
  TabDataNodeCopyWith<$R, TabDataNode, $Out> get $asTabDataNode =>
      $base.as((v, t, t2) => _TabDataNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TabDataNodeCopyWith<$R, $In extends TabDataNode, $Out>
    implements SCCopyWith<$R, $In, $Out> {
  @override
  SNodeCopyWith<$R, SNode, SNode>? get child;
  @override
  $R call({String? title, SNode? child});
  TabDataNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TabDataNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TabDataNode, $Out>
    implements TabDataNodeCopyWith<$R, TabDataNode, $Out> {
  _TabDataNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TabDataNode> $mapper =
      TabDataNodeMapper.ensureInitialized();
  @override
  SNodeCopyWith<$R, SNode, SNode>? get child =>
      $value.child?.copyWith.$chain((v) => call(child: v));
  @override
  $R call({String? title, Object? child = $none}) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (child != $none) #child: child,
    }),
  );
  @override
  TabDataNode $make(CopyWithData data) => TabDataNode(
    title: data.get(#title, or: $value.title),
    child: data.get(#child, or: $value.child),
  );

  @override
  TabDataNodeCopyWith<$R2, TabDataNode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TabDataNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

