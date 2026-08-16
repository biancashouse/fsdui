// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enum_css_grid_fit.dart';

class CSSGridFitEnumModelMapper extends EnumMapper<CSSGridFitEnumModel> {
  CSSGridFitEnumModelMapper._();

  static CSSGridFitEnumModelMapper? _instance;
  static CSSGridFitEnumModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CSSGridFitEnumModelMapper._());
    }
    return _instance!;
  }

  static CSSGridFitEnumModel fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CSSGridFitEnumModel decode(dynamic value) {
    switch (value) {
      case r'expand':
        return CSSGridFitEnumModel.expand;
      case r'loose':
        return CSSGridFitEnumModel.loose;
      case r'passthrough':
        return CSSGridFitEnumModel.passthrough;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CSSGridFitEnumModel self) {
    switch (self) {
      case CSSGridFitEnumModel.expand:
        return r'expand';
      case CSSGridFitEnumModel.loose:
        return r'loose';
      case CSSGridFitEnumModel.passthrough:
        return r'passthrough';
    }
  }
}

extension CSSGridFitEnumModelMapperExtension on CSSGridFitEnumModel {
  String toValue() {
    CSSGridFitEnumModelMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CSSGridFitEnumModel>(this) as String;
  }
}

