// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'upto6colors.dart';

class UpTo6ColorsMapper extends ClassMapperBase<UpTo6Colors> {
  UpTo6ColorsMapper._();

  static UpTo6ColorsMapper? _instance;
  static UpTo6ColorsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpTo6ColorsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UpTo6Colors';

  static Color? _$color1(UpTo6Colors v) => v.color1;
  static const Field<UpTo6Colors, Color> _f$color1 =
      Field('color1', _$color1, opt: true);
  static Color? _$color2(UpTo6Colors v) => v.color2;
  static const Field<UpTo6Colors, Color> _f$color2 =
      Field('color2', _$color2, opt: true);
  static Color? _$color3(UpTo6Colors v) => v.color3;
  static const Field<UpTo6Colors, Color> _f$color3 =
      Field('color3', _$color3, opt: true);
  static Color? _$color4(UpTo6Colors v) => v.color4;
  static const Field<UpTo6Colors, Color> _f$color4 =
      Field('color4', _$color4, opt: true);
  static Color? _$color5(UpTo6Colors v) => v.color5;
  static const Field<UpTo6Colors, Color> _f$color5 =
      Field('color5', _$color5, opt: true);
  static Color? _$color6(UpTo6Colors v) => v.color6;
  static const Field<UpTo6Colors, Color> _f$color6 =
      Field('color6', _$color6, opt: true);
  static bool? _$isLinear(UpTo6Colors v) => v.isLinear;
  static const Field<UpTo6Colors, bool> _f$isLinear =
      Field('isLinear', _$isLinear, mode: FieldMode.member);

  @override
  final MappableFields<UpTo6Colors> fields = const {
    #color1: _f$color1,
    #color2: _f$color2,
    #color3: _f$color3,
    #color4: _f$color4,
    #color5: _f$color5,
    #color6: _f$color6,
    #isLinear: _f$isLinear,
  };

  static UpTo6Colors _instantiate(DecodingData data) {
    return UpTo6Colors(
        color1: data.dec(_f$color1),
        color2: data.dec(_f$color2),
        color3: data.dec(_f$color3),
        color4: data.dec(_f$color4),
        color5: data.dec(_f$color5),
        color6: data.dec(_f$color6));
  }

  @override
  final Function instantiate = _instantiate;

  static UpTo6Colors fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpTo6Colors>(map);
  }

  static UpTo6Colors fromJson(String json) {
    return ensureInitialized().decodeJson<UpTo6Colors>(json);
  }
}

mixin UpTo6ColorsMappable {
  String toJson() {
    return UpTo6ColorsMapper.ensureInitialized()
        .encodeJson<UpTo6Colors>(this as UpTo6Colors);
  }

  Map<String, dynamic> toMap() {
    return UpTo6ColorsMapper.ensureInitialized()
        .encodeMap<UpTo6Colors>(this as UpTo6Colors);
  }

  UpTo6ColorsCopyWith<UpTo6Colors, UpTo6Colors, UpTo6Colors> get copyWith =>
      _UpTo6ColorsCopyWithImpl<UpTo6Colors, UpTo6Colors>(
          this as UpTo6Colors, $identity, $identity);
  @override
  String toString() {
    return UpTo6ColorsMapper.ensureInitialized()
        .stringifyValue(this as UpTo6Colors);
  }

  @override
  bool operator ==(Object other) {
    return UpTo6ColorsMapper.ensureInitialized()
        .equalsValue(this as UpTo6Colors, other);
  }

  @override
  int get hashCode {
    return UpTo6ColorsMapper.ensureInitialized().hashValue(this as UpTo6Colors);
  }
}

extension UpTo6ColorsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpTo6Colors, $Out> {
  UpTo6ColorsCopyWith<$R, UpTo6Colors, $Out> get $asUpTo6Colors =>
      $base.as((v, t, t2) => _UpTo6ColorsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UpTo6ColorsCopyWith<$R, $In extends UpTo6Colors, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {Color? color1,
      Color? color2,
      Color? color3,
      Color? color4,
      Color? color5,
      Color? color6});
  UpTo6ColorsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UpTo6ColorsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpTo6Colors, $Out>
    implements UpTo6ColorsCopyWith<$R, UpTo6Colors, $Out> {
  _UpTo6ColorsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpTo6Colors> $mapper =
      UpTo6ColorsMapper.ensureInitialized();
  @override
  $R call(
          {Object? color1 = $none,
          Object? color2 = $none,
          Object? color3 = $none,
          Object? color4 = $none,
          Object? color5 = $none,
          Object? color6 = $none}) =>
      $apply(FieldCopyWithData({
        if (color1 != $none) #color1: color1,
        if (color2 != $none) #color2: color2,
        if (color3 != $none) #color3: color3,
        if (color4 != $none) #color4: color4,
        if (color5 != $none) #color5: color5,
        if (color6 != $none) #color6: color6
      }));
  @override
  UpTo6Colors $make(CopyWithData data) => UpTo6Colors(
      color1: data.get(#color1, or: $value.color1),
      color2: data.get(#color2, or: $value.color2),
      color3: data.get(#color3, or: $value.color3),
      color4: data.get(#color4, or: $value.color4),
      color5: data.get(#color5, or: $value.color5),
      color6: data.get(#color6, or: $value.color6));

  @override
  UpTo6ColorsCopyWith<$R2, UpTo6Colors, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UpTo6ColorsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
