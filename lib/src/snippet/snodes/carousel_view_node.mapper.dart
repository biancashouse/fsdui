// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
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
      SNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CarouselViewNode';

  static String? _$name(CarouselViewNode v) => v.name;
  static const Field<CarouselViewNode, String> _f$name =
      Field('name', _$name, opt: true);
  static double _$height(CarouselViewNode v) => v.height;
  static const Field<CarouselViewNode, double> _f$height =
      Field('height', _$height, opt: true, def: 200);
  static bool _$autoPlay(CarouselViewNode v) => v.autoPlay;
  static const Field<CarouselViewNode, bool> _f$autoPlay =
      Field('autoPlay', _$autoPlay, opt: true, def: false);
  static List<SNode> _$children(CarouselViewNode v) => v.children;
  static const Field<CarouselViewNode, List<SNode>> _f$children =
      Field('children', _$children);
  static String _$uid(CarouselViewNode v) => v.uid;
  static const Field<CarouselViewNode, String> _f$uid =
      Field('uid', _$uid, mode: FieldMode.member);
  static List<String>? _$tags(CarouselViewNode v) => v.tags;
  static const Field<CarouselViewNode, List<String>> _f$tags =
      Field('tags', _$tags, mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(CarouselViewNode v) =>
      v.treeNodeGK;
  static const Field<CarouselViewNode, GlobalKey<State<StatefulWidget>>>
      _f$treeNodeGK = Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(CarouselViewNode v) => v.isExpanded;
  static const Field<CarouselViewNode, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, mode: FieldMode.member);
  static bool? _$hidePropertiesWhileDragging(CarouselViewNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<CarouselViewNode, bool> _f$hidePropertiesWhileDragging =
      Field('hidePropertiesWhileDragging', _$hidePropertiesWhileDragging,
          mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(CarouselViewNode v) =>
      v.nodeGK;
  static const Field<CarouselViewNode, GlobalKey<State<StatefulWidget>>>
      _f$nodeGK = Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<CarouselViewNode> fields = const {
    #name: _f$name,
    #height: _f$height,
    #autoPlay: _f$autoPlay,
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
        height: data.dec(_f$height),
        autoPlay: data.dec(_f$autoPlay),
        children: data.dec(_f$children));
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
              this as CarouselViewNode, $identity, $identity);
  @override
  String toString() {
    return CarouselViewNodeMapper.ensureInitialized()
        .stringifyValue(this as CarouselViewNode);
  }

  @override
  bool operator ==(Object other) {
    return CarouselViewNodeMapper.ensureInitialized()
        .equalsValue(this as CarouselViewNode, other);
  }

  @override
  int get hashCode {
    return CarouselViewNodeMapper.ensureInitialized()
        .hashValue(this as CarouselViewNode);
  }
}

extension CarouselViewNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CarouselViewNode, $Out> {
  CarouselViewNodeCopyWith<$R, CarouselViewNode, $Out>
      get $asCarouselViewNode => $base
          .as((v, t, t2) => _CarouselViewNodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarouselViewNodeCopyWith<$R, $In extends CarouselViewNode, $Out>
    implements SNodeCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SNode, SNodeCopyWith<$R, SNode, SNode>> get children;
  @override
  $R call(
      {String? name, double? height, bool? autoPlay, List<SNode>? children});
  CarouselViewNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
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
      ListCopyWith($value.children, (v, t) => v.copyWith.$chain(t),
          (v) => call(children: v));
  @override
  $R call(
          {Object? name = $none,
          double? height,
          bool? autoPlay,
          List<SNode>? children}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (height != null) #height: height,
        if (autoPlay != null) #autoPlay: autoPlay,
        if (children != null) #children: children
      }));
  @override
  CarouselViewNode $make(CopyWithData data) => CarouselViewNode(
      name: data.get(#name, or: $value.name),
      height: data.get(#height, or: $value.height),
      autoPlay: data.get(#autoPlay, or: $value.autoPlay),
      children: data.get(#children, or: $value.children));

  @override
  CarouselViewNodeCopyWith<$R2, CarouselViewNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CarouselViewNodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
