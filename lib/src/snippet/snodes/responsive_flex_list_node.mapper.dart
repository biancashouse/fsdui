// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'responsive_flex_list_node.dart';

class ResponsiveFlexListNodeMapper
    extends SubClassMapperBase<ResponsiveFlexListNode> {
  ResponsiveFlexListNodeMapper._();

  static ResponsiveFlexListNodeMapper? _instance;
  static ResponsiveFlexListNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ResponsiveFlexListNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      RFLAnimationTypeEnumModelMapper.ensureInitialized();
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ResponsiveFlexListNode';

  static String? _$name(ResponsiveFlexListNode v) => v.name;
  static const Field<ResponsiveFlexListNode, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static EdgeInsets? _$padding(ResponsiveFlexListNode v) => v.padding;
  static const Field<ResponsiveFlexListNode, EdgeInsets> _f$padding = Field(
    'padding',
    _$padding,
    opt: true,
  );
  static int? _$crossAxisCount(ResponsiveFlexListNode v) => v.crossAxisCount;
  static const Field<ResponsiveFlexListNode, int> _f$crossAxisCount = Field(
    'crossAxisCount',
    _$crossAxisCount,
    opt: true,
  );
  static int? _$minCrossAxisCount(ResponsiveFlexListNode v) =>
      v.minCrossAxisCount;
  static const Field<ResponsiveFlexListNode, int> _f$minCrossAxisCount = Field(
    'minCrossAxisCount',
    _$minCrossAxisCount,
    opt: true,
  );
  static int? _$maxCrossAxisCount(ResponsiveFlexListNode v) =>
      v.maxCrossAxisCount;
  static const Field<ResponsiveFlexListNode, int> _f$maxCrossAxisCount = Field(
    'maxCrossAxisCount',
    _$maxCrossAxisCount,
    opt: true,
  );
  static double? _$mainAxisSpacing(ResponsiveFlexListNode v) =>
      v.mainAxisSpacing;
  static const Field<ResponsiveFlexListNode, double> _f$mainAxisSpacing = Field(
    'mainAxisSpacing',
    _$mainAxisSpacing,
    opt: true,
  );
  static double? _$crossAxisSpacing(ResponsiveFlexListNode v) =>
      v.crossAxisSpacing;
  static const Field<ResponsiveFlexListNode, double> _f$crossAxisSpacing =
      Field('crossAxisSpacing', _$crossAxisSpacing, opt: true);
  static double? _$childAspectRatio(ResponsiveFlexListNode v) =>
      v.childAspectRatio;
  static const Field<ResponsiveFlexListNode, double> _f$childAspectRatio =
      Field('childAspectRatio', _$childAspectRatio, opt: true);
  static bool? _$shrinkWrap(ResponsiveFlexListNode v) => v.shrinkWrap;
  static const Field<ResponsiveFlexListNode, bool> _f$shrinkWrap = Field(
    'shrinkWrap',
    _$shrinkWrap,
    opt: true,
  );
  static bool? _$reverse(ResponsiveFlexListNode v) => v.reverse;
  static const Field<ResponsiveFlexListNode, bool> _f$reverse = Field(
    'reverse',
    _$reverse,
    opt: true,
  );
  static bool? _$useIntrinsicHeight(ResponsiveFlexListNode v) =>
      v.useIntrinsicHeight;
  static const Field<ResponsiveFlexListNode, bool> _f$useIntrinsicHeight =
      Field('useIntrinsicHeight', _$useIntrinsicHeight, opt: true);
  static bool? _$roundRobinLayout(ResponsiveFlexListNode v) =>
      v.roundRobinLayout;
  static const Field<ResponsiveFlexListNode, bool> _f$roundRobinLayout = Field(
    'roundRobinLayout',
    _$roundRobinLayout,
    opt: true,
  );
  static RFLAnimationTypeEnumModel? _$animationType(ResponsiveFlexListNode v) =>
      v.animationType;
  static const Field<ResponsiveFlexListNode, RFLAnimationTypeEnumModel>
  _f$animationType = Field('animationType', _$animationType, opt: true);
  static double? _$animationDurationMs(ResponsiveFlexListNode v) =>
      v.animationDurationMs;
  static const Field<ResponsiveFlexListNode, double> _f$animationDurationMs =
      Field('animationDurationMs', _$animationDurationMs, opt: true);
  static double? _$staggerDelayMs(ResponsiveFlexListNode v) => v.staggerDelayMs;
  static const Field<ResponsiveFlexListNode, double> _f$staggerDelayMs = Field(
    'staggerDelayMs',
    _$staggerDelayMs,
    opt: true,
  );
  static List<SNode> _$children(ResponsiveFlexListNode v) => v.children;
  static const Field<ResponsiveFlexListNode, List<SNode>> _f$children = Field(
    'children',
    _$children,
  );
  static String _$uid(ResponsiveFlexListNode v) => v.uid;
  static const Field<ResponsiveFlexListNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(ResponsiveFlexListNode v) => v.tags;
  static const Field<ResponsiveFlexListNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(
    ResponsiveFlexListNode v,
  ) => v.treeNodeGK;
  static const Field<ResponsiveFlexListNode, GlobalKey<State<StatefulWidget>>>
  _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(ResponsiveFlexListNode v) => v.isExpanded;
  static const Field<ResponsiveFlexListNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(ResponsiveFlexListNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<ResponsiveFlexListNode, bool>
  _f$hidePropertiesWhileDragging = Field(
    'hidePropertiesWhileDragging',
    _$hidePropertiesWhileDragging,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(ResponsiveFlexListNode v) =>
      v.nodeGK;
  static const Field<ResponsiveFlexListNode, GlobalKey<State<StatefulWidget>>>
  _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<ResponsiveFlexListNode> fields = const {
    #name: _f$name,
    #padding: _f$padding,
    #crossAxisCount: _f$crossAxisCount,
    #minCrossAxisCount: _f$minCrossAxisCount,
    #maxCrossAxisCount: _f$maxCrossAxisCount,
    #mainAxisSpacing: _f$mainAxisSpacing,
    #crossAxisSpacing: _f$crossAxisSpacing,
    #childAspectRatio: _f$childAspectRatio,
    #shrinkWrap: _f$shrinkWrap,
    #reverse: _f$reverse,
    #useIntrinsicHeight: _f$useIntrinsicHeight,
    #roundRobinLayout: _f$roundRobinLayout,
    #animationType: _f$animationType,
    #animationDurationMs: _f$animationDurationMs,
    #staggerDelayMs: _f$staggerDelayMs,
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
  final dynamic discriminatorValue = 'ResponsiveFlexListNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static ResponsiveFlexListNode _instantiate(DecodingData data) {
    return ResponsiveFlexListNode(
      name: data.dec(_f$name),
      padding: data.dec(_f$padding),
      crossAxisCount: data.dec(_f$crossAxisCount),
      minCrossAxisCount: data.dec(_f$minCrossAxisCount),
      maxCrossAxisCount: data.dec(_f$maxCrossAxisCount),
      mainAxisSpacing: data.dec(_f$mainAxisSpacing),
      crossAxisSpacing: data.dec(_f$crossAxisSpacing),
      childAspectRatio: data.dec(_f$childAspectRatio),
      shrinkWrap: data.dec(_f$shrinkWrap),
      reverse: data.dec(_f$reverse),
      useIntrinsicHeight: data.dec(_f$useIntrinsicHeight),
      roundRobinLayout: data.dec(_f$roundRobinLayout),
      animationType: data.dec(_f$animationType),
      animationDurationMs: data.dec(_f$animationDurationMs),
      staggerDelayMs: data.dec(_f$staggerDelayMs),
      children: data.dec(_f$children),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ResponsiveFlexListNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ResponsiveFlexListNode>(map);
  }

  static ResponsiveFlexListNode fromJson(String json) {
    return ensureInitialized().decodeJson<ResponsiveFlexListNode>(json);
  }
}

mixin ResponsiveFlexListNodeMappable {
  String toJson() {
    return ResponsiveFlexListNodeMapper.ensureInitialized()
        .encodeJson<ResponsiveFlexListNode>(this as ResponsiveFlexListNode);
  }

  Map<String, dynamic> toMap() {
    return ResponsiveFlexListNodeMapper.ensureInitialized()
        .encodeMap<ResponsiveFlexListNode>(this as ResponsiveFlexListNode);
  }

  ResponsiveFlexListNodeCopyWith<
    ResponsiveFlexListNode,
    ResponsiveFlexListNode,
    ResponsiveFlexListNode
  >
  get copyWith =>
      _ResponsiveFlexListNodeCopyWithImpl<
        ResponsiveFlexListNode,
        ResponsiveFlexListNode
      >(this as ResponsiveFlexListNode, $identity, $identity);
  @override
  String toString() {
    return ResponsiveFlexListNodeMapper.ensureInitialized().stringifyValue(
      this as ResponsiveFlexListNode,
    );
  }

  @override
  bool operator ==(Object other) {
    return ResponsiveFlexListNodeMapper.ensureInitialized().equalsValue(
      this as ResponsiveFlexListNode,
      other,
    );
  }

  @override
  int get hashCode {
    return ResponsiveFlexListNodeMapper.ensureInitialized().hashValue(
      this as ResponsiveFlexListNode,
    );
  }
}

extension ResponsiveFlexListNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ResponsiveFlexListNode, $Out> {
  ResponsiveFlexListNodeCopyWith<$R, ResponsiveFlexListNode, $Out>
  get $asResponsiveFlexListNode => $base.as(
    (v, t, t2) => _ResponsiveFlexListNodeCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ResponsiveFlexListNodeCopyWith<
  $R,
  $In extends ResponsiveFlexListNode,
  $Out
>
    implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call({
    String? name,
    EdgeInsets? padding,
    int? crossAxisCount,
    int? minCrossAxisCount,
    int? maxCrossAxisCount,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    double? childAspectRatio,
    bool? shrinkWrap,
    bool? reverse,
    bool? useIntrinsicHeight,
    bool? roundRobinLayout,
    RFLAnimationTypeEnumModel? animationType,
    double? animationDurationMs,
    double? staggerDelayMs,
    List<SNode>? children,
  });
  ResponsiveFlexListNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ResponsiveFlexListNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ResponsiveFlexListNode, $Out>
    implements
        ResponsiveFlexListNodeCopyWith<$R, ResponsiveFlexListNode, $Out> {
  _ResponsiveFlexListNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ResponsiveFlexListNode> $mapper =
      ResponsiveFlexListNodeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children =>
      ListCopyWith(
        $value.children,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(children: v),
      );
  @override
  $R call({
    Object? name = $none,
    Object? padding = $none,
    Object? crossAxisCount = $none,
    Object? minCrossAxisCount = $none,
    Object? maxCrossAxisCount = $none,
    Object? mainAxisSpacing = $none,
    Object? crossAxisSpacing = $none,
    Object? childAspectRatio = $none,
    Object? shrinkWrap = $none,
    Object? reverse = $none,
    Object? useIntrinsicHeight = $none,
    Object? roundRobinLayout = $none,
    Object? animationType = $none,
    Object? animationDurationMs = $none,
    Object? staggerDelayMs = $none,
    List<SNode>? children,
  }) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (padding != $none) #padding: padding,
      if (crossAxisCount != $none) #crossAxisCount: crossAxisCount,
      if (minCrossAxisCount != $none) #minCrossAxisCount: minCrossAxisCount,
      if (maxCrossAxisCount != $none) #maxCrossAxisCount: maxCrossAxisCount,
      if (mainAxisSpacing != $none) #mainAxisSpacing: mainAxisSpacing,
      if (crossAxisSpacing != $none) #crossAxisSpacing: crossAxisSpacing,
      if (childAspectRatio != $none) #childAspectRatio: childAspectRatio,
      if (shrinkWrap != $none) #shrinkWrap: shrinkWrap,
      if (reverse != $none) #reverse: reverse,
      if (useIntrinsicHeight != $none) #useIntrinsicHeight: useIntrinsicHeight,
      if (roundRobinLayout != $none) #roundRobinLayout: roundRobinLayout,
      if (animationType != $none) #animationType: animationType,
      if (animationDurationMs != $none)
        #animationDurationMs: animationDurationMs,
      if (staggerDelayMs != $none) #staggerDelayMs: staggerDelayMs,
      if (children != null) #children: children,
    }),
  );
  @override
  ResponsiveFlexListNode $make(CopyWithData data) => ResponsiveFlexListNode(
    name: data.get(#name, or: $value.name),
    padding: data.get(#padding, or: $value.padding),
    crossAxisCount: data.get(#crossAxisCount, or: $value.crossAxisCount),
    minCrossAxisCount: data.get(
      #minCrossAxisCount,
      or: $value.minCrossAxisCount,
    ),
    maxCrossAxisCount: data.get(
      #maxCrossAxisCount,
      or: $value.maxCrossAxisCount,
    ),
    mainAxisSpacing: data.get(#mainAxisSpacing, or: $value.mainAxisSpacing),
    crossAxisSpacing: data.get(#crossAxisSpacing, or: $value.crossAxisSpacing),
    childAspectRatio: data.get(#childAspectRatio, or: $value.childAspectRatio),
    shrinkWrap: data.get(#shrinkWrap, or: $value.shrinkWrap),
    reverse: data.get(#reverse, or: $value.reverse),
    useIntrinsicHeight: data.get(
      #useIntrinsicHeight,
      or: $value.useIntrinsicHeight,
    ),
    roundRobinLayout: data.get(#roundRobinLayout, or: $value.roundRobinLayout),
    animationType: data.get(#animationType, or: $value.animationType),
    animationDurationMs: data.get(
      #animationDurationMs,
      or: $value.animationDurationMs,
    ),
    staggerDelayMs: data.get(#staggerDelayMs, or: $value.staggerDelayMs),
    children: data.get(#children, or: $value.children),
  );

  @override
  ResponsiveFlexListNodeCopyWith<$R2, ResponsiveFlexListNode, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ResponsiveFlexListNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

