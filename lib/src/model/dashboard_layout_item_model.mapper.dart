// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dashboard_layout_item_model.dart';

class DashboardLayoutItemModelMapper
    extends ClassMapperBase<DashboardLayoutItemModel> {
  DashboardLayoutItemModelMapper._();

  static DashboardLayoutItemModelMapper? _instance;
  static DashboardLayoutItemModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = DashboardLayoutItemModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'DashboardLayoutItemModel';

  static int _$x(DashboardLayoutItemModel v) => v.x;
  static const Field<DashboardLayoutItemModel, int> _f$x = Field('x', _$x);
  static int _$y(DashboardLayoutItemModel v) => v.y;
  static const Field<DashboardLayoutItemModel, int> _f$y = Field('y', _$y);
  static int _$w(DashboardLayoutItemModel v) => v.w;
  static const Field<DashboardLayoutItemModel, int> _f$w = Field('w', _$w);
  static int _$h(DashboardLayoutItemModel v) => v.h;
  static const Field<DashboardLayoutItemModel, int> _f$h = Field('h', _$h);

  @override
  final MappableFields<DashboardLayoutItemModel> fields = const {
    #x: _f$x,
    #y: _f$y,
    #w: _f$w,
    #h: _f$h,
  };

  static DashboardLayoutItemModel _instantiate(DecodingData data) {
    return DashboardLayoutItemModel(
      x: data.dec(_f$x),
      y: data.dec(_f$y),
      w: data.dec(_f$w),
      h: data.dec(_f$h),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DashboardLayoutItemModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DashboardLayoutItemModel>(map);
  }

  static DashboardLayoutItemModel fromJson(String json) {
    return ensureInitialized().decodeJson<DashboardLayoutItemModel>(json);
  }
}

mixin DashboardLayoutItemModelMappable {
  String toJson() {
    return DashboardLayoutItemModelMapper.ensureInitialized()
        .encodeJson<DashboardLayoutItemModel>(this as DashboardLayoutItemModel);
  }

  Map<String, dynamic> toMap() {
    return DashboardLayoutItemModelMapper.ensureInitialized()
        .encodeMap<DashboardLayoutItemModel>(this as DashboardLayoutItemModel);
  }

  DashboardLayoutItemModelCopyWith<
    DashboardLayoutItemModel,
    DashboardLayoutItemModel,
    DashboardLayoutItemModel
  >
  get copyWith =>
      _DashboardLayoutItemModelCopyWithImpl<
        DashboardLayoutItemModel,
        DashboardLayoutItemModel
      >(this as DashboardLayoutItemModel, $identity, $identity);
  @override
  String toString() {
    return DashboardLayoutItemModelMapper.ensureInitialized().stringifyValue(
      this as DashboardLayoutItemModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return DashboardLayoutItemModelMapper.ensureInitialized().equalsValue(
      this as DashboardLayoutItemModel,
      other,
    );
  }

  @override
  int get hashCode {
    return DashboardLayoutItemModelMapper.ensureInitialized().hashValue(
      this as DashboardLayoutItemModel,
    );
  }
}

extension DashboardLayoutItemModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DashboardLayoutItemModel, $Out> {
  DashboardLayoutItemModelCopyWith<$R, DashboardLayoutItemModel, $Out>
  get $asDashboardLayoutItemModel => $base.as(
    (v, t, t2) => _DashboardLayoutItemModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DashboardLayoutItemModelCopyWith<
  $R,
  $In extends DashboardLayoutItemModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? x, int? y, int? w, int? h});
  DashboardLayoutItemModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DashboardLayoutItemModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DashboardLayoutItemModel, $Out>
    implements
        DashboardLayoutItemModelCopyWith<$R, DashboardLayoutItemModel, $Out> {
  _DashboardLayoutItemModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DashboardLayoutItemModel> $mapper =
      DashboardLayoutItemModelMapper.ensureInitialized();
  @override
  $R call({int? x, int? y, int? w, int? h}) => $apply(
    FieldCopyWithData({
      if (x != null) #x: x,
      if (y != null) #y: y,
      if (w != null) #w: w,
      if (h != null) #h: h,
    }),
  );
  @override
  DashboardLayoutItemModel $make(CopyWithData data) => DashboardLayoutItemModel(
    x: data.get(#x, or: $value.x),
    y: data.get(#y, or: $value.y),
    w: data.get(#w, or: $value.w),
    h: data.get(#h, or: $value.h),
  );

  @override
  DashboardLayoutItemModelCopyWith<$R2, DashboardLayoutItemModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DashboardLayoutItemModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

