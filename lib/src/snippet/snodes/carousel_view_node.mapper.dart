// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'carousel_view_node.dart';

class CarouselViewNodeMapper extends SubClassMapperBase<CarouselViewNode> {
  CarouselViewNodeMapper._();

  static CarouselViewNodeMapper? _instance;
  static CarouselViewNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CarouselViewNodeMapper._());
      SNodeMapper.ensureInitialized().addSubMapper(_instance!);
      AxisEnumMapper.ensureInitialized();
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CarouselViewNode';

  static String? _$name(CarouselViewNode v) => v.name;
  static const Field<CarouselViewNode, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static Color? _$backgroundColor(CarouselViewNode v) => v.backgroundColor;
  static const Field<CarouselViewNode, Color> _f$backgroundColor = Field(
    'backgroundColor',
    _$backgroundColor,
    opt: true,
  );
  static Color? _$overlayColor(CarouselViewNode v) => v.overlayColor;
  static const Field<CarouselViewNode, Color> _f$overlayColor = Field(
    'overlayColor',
    _$overlayColor,
    opt: true,
  );
  static EdgeInsets? _$padding(CarouselViewNode v) => v.padding;
  static const Field<CarouselViewNode, EdgeInsets> _f$padding = Field(
    'padding',
    _$padding,
    opt: true,
  );
  static EdgeInsets? _$margin(CarouselViewNode v) => v.margin;
  static const Field<CarouselViewNode, EdgeInsets> _f$margin = Field(
    'margin',
    _$margin,
    opt: true,
  );
  static double? _$elevation(CarouselViewNode v) => v.elevation;
  static const Field<CarouselViewNode, double> _f$elevation = Field(
    'elevation',
    _$elevation,
    opt: true,
  );
  static bool _$itemSnapping(CarouselViewNode v) => v.itemSnapping;
  static const Field<CarouselViewNode, bool> _f$itemSnapping = Field(
    'itemSnapping',
    _$itemSnapping,
    opt: true,
    def: false,
  );
  static AxisEnum _$scrollDirection(CarouselViewNode v) => v.scrollDirection;
  static const Field<CarouselViewNode, AxisEnum> _f$scrollDirection = Field(
    'scrollDirection',
    _$scrollDirection,
    opt: true,
    def: AxisEnum.horizontal,
  );
  static double _$shrinkExtent(CarouselViewNode v) => v.shrinkExtent;
  static const Field<CarouselViewNode, double> _f$shrinkExtent = Field(
    'shrinkExtent',
    _$shrinkExtent,
    opt: true,
    def: 0.0,
  );
  static double? _$itemExtent(CarouselViewNode v) => v.itemExtent;
  static const Field<CarouselViewNode, double> _f$itemExtent = Field(
    'itemExtent',
    _$itemExtent,
    opt: true,
    def: 600.0,
  );
  static bool _$infinite(CarouselViewNode v) => v.infinite;
  static const Field<CarouselViewNode, bool> _f$infinite = Field(
    'infinite',
    _$infinite,
    opt: true,
    def: false,
  );
  static bool _$autoPlay(CarouselViewNode v) => v.autoPlay;
  static const Field<CarouselViewNode, bool> _f$autoPlay = Field(
    'autoPlay',
    _$autoPlay,
    opt: true,
    def: false,
  );
  static double _$autoPlayIntervalSecs(CarouselViewNode v) =>
      v.autoPlayIntervalSecs;
  static const Field<CarouselViewNode, double> _f$autoPlayIntervalSecs = Field(
    'autoPlayIntervalSecs',
    _$autoPlayIntervalSecs,
    opt: true,
    def: 3.0,
  );
  static List<SNode> _$children(CarouselViewNode v) => v.children;
  static const Field<CarouselViewNode, List<SNode>> _f$children = Field(
    'children',
    _$children,
  );
  static String _$uid(CarouselViewNode v) => v.uid;
  static const Field<CarouselViewNode, String> _f$uid = Field(
    'uid',
    _$uid,
    mode: FieldMode.member,
  );
  static List<String>? _$tags(CarouselViewNode v) => v.tags;
  static const Field<CarouselViewNode, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    mode: FieldMode.member,
  );
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(CarouselViewNode v) =>
      v.treeNodeGK;
  static const Field<CarouselViewNode, GlobalKey<State<StatefulWidget>>>
  _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(CarouselViewNode v) => v.isExpanded;
  static const Field<CarouselViewNode, bool> _f$isExpanded = Field(
    'isExpanded',
    _$isExpanded,
    mode: FieldMode.member,
  );
  static bool? _$hidePropertiesWhileDragging(CarouselViewNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<CarouselViewNode, bool> _f$hidePropertiesWhileDragging =
      Field(
        'hidePropertiesWhileDragging',
        _$hidePropertiesWhileDragging,
        mode: FieldMode.member,
      );
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(CarouselViewNode v) =>
      v.nodeGK;
  static const Field<CarouselViewNode, GlobalKey<State<StatefulWidget>>>
  _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<CarouselViewNode> fields = const {
    #name: _f$name,
    #backgroundColor: _f$backgroundColor,
    #overlayColor: _f$overlayColor,
    #padding: _f$padding,
    #margin: _f$margin,
    #elevation: _f$elevation,
    #itemSnapping: _f$itemSnapping,
    #scrollDirection: _f$scrollDirection,
    #shrinkExtent: _f$shrinkExtent,
    #itemExtent: _f$itemExtent,
    #infinite: _f$infinite,
    #autoPlay: _f$autoPlay,
    #autoPlayIntervalSecs: _f$autoPlayIntervalSecs,
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
  final dynamic discriminatorValue = 'CarouselViewNode';
  @override
  late final ClassMapperBase superMapper = SNodeMapper.ensureInitialized();

  @override
  final MappingHook superHook = const PropertyRenameHook('snode', 'DK:snode');

  static CarouselViewNode _instantiate(DecodingData data) {
    return CarouselViewNode(
      name: data.dec(_f$name),
      backgroundColor: data.dec(_f$backgroundColor),
      overlayColor: data.dec(_f$overlayColor),
      padding: data.dec(_f$padding),
      margin: data.dec(_f$margin),
      elevation: data.dec(_f$elevation),
      itemSnapping: data.dec(_f$itemSnapping),
      scrollDirection: data.dec(_f$scrollDirection),
      shrinkExtent: data.dec(_f$shrinkExtent),
      itemExtent: data.dec(_f$itemExtent),
      infinite: data.dec(_f$infinite),
      autoPlay: data.dec(_f$autoPlay),
      autoPlayIntervalSecs: data.dec(_f$autoPlayIntervalSecs),
      children: data.dec(_f$children),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CarouselViewNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CarouselViewNode>(map);
  }

  static CarouselViewNode fromJson(String json) {
    return ensureInitialized().decodeJson<CarouselViewNode>(json);
  }
}

mixin CarouselViewNodeMappable {
  String toJson() {
    return CarouselViewNodeMapper.ensureInitialized()
        .encodeJson<CarouselViewNode>(this as CarouselViewNode);
  }

  Map<String, dynamic> toMap() {
    return CarouselViewNodeMapper.ensureInitialized()
        .encodeMap<CarouselViewNode>(this as CarouselViewNode);
  }

  CarouselViewNodeCopyWith<CarouselViewNode, CarouselViewNode, CarouselViewNode>
  get copyWith =>
      _CarouselViewNodeCopyWithImpl<CarouselViewNode, CarouselViewNode>(
        this as CarouselViewNode,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CarouselViewNodeMapper.ensureInitialized().stringifyValue(
      this as CarouselViewNode,
    );
  }

  @override
  bool operator ==(Object other) {
    return CarouselViewNodeMapper.ensureInitialized().equalsValue(
      this as CarouselViewNode,
      other,
    );
  }

  @override
  int get hashCode {
    return CarouselViewNodeMapper.ensureInitialized().hashValue(
      this as CarouselViewNode,
    );
  }
}

extension CarouselViewNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CarouselViewNode, $Out> {
  CarouselViewNodeCopyWith<$R, CarouselViewNode, $Out>
  get $asCarouselViewNode =>
      $base.as((v, t, t2) => _CarouselViewNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarouselViewNodeCopyWith<$R, $In extends CarouselViewNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call({
    String? name,
    Color? backgroundColor,
    Color? overlayColor,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? elevation,
    bool? itemSnapping,
    AxisEnum? scrollDirection,
    double? shrinkExtent,
    double? itemExtent,
    bool? infinite,
    bool? autoPlay,
    double? autoPlayIntervalSecs,
    List<SNode>? children,
  });
  CarouselViewNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CarouselViewNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CarouselViewNode, $Out>
    implements CarouselViewNodeCopyWith<$R, CarouselViewNode, $Out> {
  _CarouselViewNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CarouselViewNode> $mapper =
      CarouselViewNodeMapper.ensureInitialized();
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
    Object? backgroundColor = $none,
    Object? overlayColor = $none,
    Object? padding = $none,
    Object? margin = $none,
    Object? elevation = $none,
    bool? itemSnapping,
    AxisEnum? scrollDirection,
    double? shrinkExtent,
    Object? itemExtent = $none,
    bool? infinite,
    bool? autoPlay,
    double? autoPlayIntervalSecs,
    List<SNode>? children,
  }) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (backgroundColor != $none) #backgroundColor: backgroundColor,
      if (overlayColor != $none) #overlayColor: overlayColor,
      if (padding != $none) #padding: padding,
      if (margin != $none) #margin: margin,
      if (elevation != $none) #elevation: elevation,
      if (itemSnapping != null) #itemSnapping: itemSnapping,
      if (scrollDirection != null) #scrollDirection: scrollDirection,
      if (shrinkExtent != null) #shrinkExtent: shrinkExtent,
      if (itemExtent != $none) #itemExtent: itemExtent,
      if (infinite != null) #infinite: infinite,
      if (autoPlay != null) #autoPlay: autoPlay,
      if (autoPlayIntervalSecs != null)
        #autoPlayIntervalSecs: autoPlayIntervalSecs,
      if (children != null) #children: children,
    }),
  );
  @override
  CarouselViewNode $make(CopyWithData data) => CarouselViewNode(
    name: data.get(#name, or: $value.name),
    backgroundColor: data.get(#backgroundColor, or: $value.backgroundColor),
    overlayColor: data.get(#overlayColor, or: $value.overlayColor),
    padding: data.get(#padding, or: $value.padding),
    margin: data.get(#margin, or: $value.margin),
    elevation: data.get(#elevation, or: $value.elevation),
    itemSnapping: data.get(#itemSnapping, or: $value.itemSnapping),
    scrollDirection: data.get(#scrollDirection, or: $value.scrollDirection),
    shrinkExtent: data.get(#shrinkExtent, or: $value.shrinkExtent),
    itemExtent: data.get(#itemExtent, or: $value.itemExtent),
    infinite: data.get(#infinite, or: $value.infinite),
    autoPlay: data.get(#autoPlay, or: $value.autoPlay),
    autoPlayIntervalSecs: data.get(
      #autoPlayIntervalSecs,
      or: $value.autoPlayIntervalSecs,
    ),
    children: data.get(#children, or: $value.children),
  );

  @override
  CarouselViewNodeCopyWith<$R2, CarouselViewNode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CarouselViewNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

