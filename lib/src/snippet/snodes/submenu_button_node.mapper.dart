// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'submenu_button_node.dart';

class SubmenuButtonNodeMapper extends SubClassMapperBase<SubmenuButtonNode> {
  SubmenuButtonNodeMapper._();

  static SubmenuButtonNodeMapper? _instance;
  static SubmenuButtonNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SubmenuButtonNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SubmenuButtonNode';

  static String? _$name(SubmenuButtonNode v) => v.name;
  static const Field<SubmenuButtonNode, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String _$itemLabel(SubmenuButtonNode v) => v.itemLabel;
  static const Field<SubmenuButtonNode, String> _f$itemLabel = Field(
    'itemLabel',
    _$itemLabel,
    opt: true,
    def: 'label?',
  );
  static List<SNode> _$children(SubmenuButtonNode v) => v.children;
  static const Field<SubmenuButtonNode, List<SNode>> _f$children = Field(
    'children',
    _$children,
    key: r'menuChildren',
  );
  static String _$uid(SubmenuButtonNode v) => v.uid;
  static const Field<SubmenuButtonNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(SubmenuButtonNode v) => v.tags;
  static const Field<SubmenuButtonNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(SubmenuButtonNode v) =>
      v.treeNodeGK;
  static const Field<SubmenuButtonNode, GlobalKey<State<StatefulWidget>>>
  _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(SubmenuButtonNode v) => v.isExpanded;
  static const Field<SubmenuButtonNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(SubmenuButtonNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<SubmenuButtonNode, bool> _f$hidePropertiesWhileDragging =
      Field(
        'hidePropertiesWhileDragging',
        _$hidePropertiesWhileDragging,
        mode: FieldMode.member,
      );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(SubmenuButtonNode v) =>
      v.nodeGK;
  static const Field<SubmenuButtonNode, GlobalKey<State<StatefulWidget>>>
  _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<SubmenuButtonNode> fields = const {
    #name: _f$name,
    #itemLabel: _f$itemLabel,
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
  final dynamic discriminatorValue = 'SubmenuButtonNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static SubmenuButtonNode _instantiate(DecodingData data) {
    return SubmenuButtonNode(
      name: data.dec(_f$name),
      itemLabel: data.dec(_f$itemLabel),
      menuChildren: data.dec(_f$children),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SubmenuButtonNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SubmenuButtonNode>(map);
  }

  static SubmenuButtonNode fromJson(String json) {
    return ensureInitialized().decodeJson<SubmenuButtonNode>(json);
  }
}

mixin SubmenuButtonNodeMappable {
  String toJson() {
    return SubmenuButtonNodeMapper.ensureInitialized()
        .encodeJson<SubmenuButtonNode>(this as SubmenuButtonNode);
  }

  Map<String, dynamic> toMap() {
    return SubmenuButtonNodeMapper.ensureInitialized()
        .encodeMap<SubmenuButtonNode>(this as SubmenuButtonNode);
  }

  SubmenuButtonNodeCopyWith<
    SubmenuButtonNode,
    SubmenuButtonNode,
    SubmenuButtonNode
  >
  get copyWith =>
      _SubmenuButtonNodeCopyWithImpl<SubmenuButtonNode, SubmenuButtonNode>(
        this as SubmenuButtonNode,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SubmenuButtonNodeMapper.ensureInitialized().stringifyValue(
      this as SubmenuButtonNode,
    );
  }

  @override
  bool operator ==(Object other) {
    return SubmenuButtonNodeMapper.ensureInitialized().equalsValue(
      this as SubmenuButtonNode,
      other,
    );
  }

  @override
  int get hashCode {
    return SubmenuButtonNodeMapper.ensureInitialized().hashValue(
      this as SubmenuButtonNode,
    );
  }
}

extension SubmenuButtonNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SubmenuButtonNode, $Out> {
  SubmenuButtonNodeCopyWith<$R, SubmenuButtonNode, $Out>
  get $asSubmenuButtonNode => $base.as(
    (v, t, t2) => _SubmenuButtonNodeCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SubmenuButtonNodeCopyWith<
  $R,
  $In extends SubmenuButtonNode,
  $Out
>
    implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call({String? name, String? itemLabel, List<SNode>? menuChildren});
  SubmenuButtonNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SubmenuButtonNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SubmenuButtonNode, $Out>
    implements SubmenuButtonNodeCopyWith<$R, SubmenuButtonNode, $Out> {
  _SubmenuButtonNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SubmenuButtonNode> $mapper =
      SubmenuButtonNodeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children =>
      ListCopyWith(
        $value.children,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(menuChildren: v),
      );
  @override
  $R call({
    Object? name = $none,
    String? itemLabel,
    List<SNode>? menuChildren,
  }) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (itemLabel != null) #itemLabel: itemLabel,
      if (menuChildren != null) #menuChildren: menuChildren,
    }),
  );
  @override
  SubmenuButtonNode $make(CopyWithData data) => SubmenuButtonNode(
    name: data.get(#name, or: $value.name),
    itemLabel: data.get(#itemLabel, or: $value.itemLabel),
    menuChildren: data.get(#menuChildren, or: $value.children),
  );

  @override
  SubmenuButtonNodeCopyWith<$R2, SubmenuButtonNode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SubmenuButtonNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

