// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enum_css_grid_auto_placement.dart';

class CSSGridAutoPlacementEnumModelMapper
    extends EnumMapper<CSSGridAutoPlacementEnumModel> {
  CSSGridAutoPlacementEnumModelMapper._();

  static CSSGridAutoPlacementEnumModelMapper? _instance;
  static CSSGridAutoPlacementEnumModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = CSSGridAutoPlacementEnumModelMapper._(),
      );
    }
    return _instance!;
  }

  static CSSGridAutoPlacementEnumModel fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CSSGridAutoPlacementEnumModel decode(dynamic value) {
    switch (value) {
      case r'rowSparse':
        return CSSGridAutoPlacementEnumModel.rowSparse;
      case r'rowDense':
        return CSSGridAutoPlacementEnumModel.rowDense;
      case r'columnSparse':
        return CSSGridAutoPlacementEnumModel.columnSparse;
      case r'columnDense':
        return CSSGridAutoPlacementEnumModel.columnDense;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CSSGridAutoPlacementEnumModel self) {
    switch (self) {
      case CSSGridAutoPlacementEnumModel.rowSparse:
        return r'rowSparse';
      case CSSGridAutoPlacementEnumModel.rowDense:
        return r'rowDense';
      case CSSGridAutoPlacementEnumModel.columnSparse:
        return r'columnSparse';
      case CSSGridAutoPlacementEnumModel.columnDense:
        return r'columnDense';
    }
  }
}

extension CSSGridAutoPlacementEnumModelMapperExtension
    on CSSGridAutoPlacementEnumModel {
  String toValue() {
    CSSGridAutoPlacementEnumModelMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CSSGridAutoPlacementEnumModel>(this)
        as String;
  }
}

