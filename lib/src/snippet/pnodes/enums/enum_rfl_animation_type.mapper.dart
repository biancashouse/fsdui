// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enum_rfl_animation_type.dart';

class RFLAnimationTypeEnumModelMapper
    extends EnumMapper<RFLAnimationTypeEnumModel> {
  RFLAnimationTypeEnumModelMapper._();

  static RFLAnimationTypeEnumModelMapper? _instance;
  static RFLAnimationTypeEnumModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = RFLAnimationTypeEnumModelMapper._(),
      );
    }
    return _instance!;
  }

  static RFLAnimationTypeEnumModel fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  RFLAnimationTypeEnumModel decode(dynamic value) {
    switch (value) {
      case r'none':
        return RFLAnimationTypeEnumModel.none;
      case r'fade':
        return RFLAnimationTypeEnumModel.fade;
      case r'scale':
        return RFLAnimationTypeEnumModel.scale;
      case r'slide':
        return RFLAnimationTypeEnumModel.slide;
      case r'slideUp':
        return RFLAnimationTypeEnumModel.slideUp;
      case r'slideDown':
        return RFLAnimationTypeEnumModel.slideDown;
      case r'rotation':
        return RFLAnimationTypeEnumModel.rotation;
      case r'bounce':
        return RFLAnimationTypeEnumModel.bounce;
      case r'flipIn':
        return RFLAnimationTypeEnumModel.flipIn;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(RFLAnimationTypeEnumModel self) {
    switch (self) {
      case RFLAnimationTypeEnumModel.none:
        return r'none';
      case RFLAnimationTypeEnumModel.fade:
        return r'fade';
      case RFLAnimationTypeEnumModel.scale:
        return r'scale';
      case RFLAnimationTypeEnumModel.slide:
        return r'slide';
      case RFLAnimationTypeEnumModel.slideUp:
        return r'slideUp';
      case RFLAnimationTypeEnumModel.slideDown:
        return r'slideDown';
      case RFLAnimationTypeEnumModel.rotation:
        return r'rotation';
      case RFLAnimationTypeEnumModel.bounce:
        return r'bounce';
      case RFLAnimationTypeEnumModel.flipIn:
        return r'flipIn';
    }
  }
}

extension RFLAnimationTypeEnumModelMapperExtension
    on RFLAnimationTypeEnumModel {
  String toValue() {
    RFLAnimationTypeEnumModelMapper.ensureInitialized();
    return MapperContainer.globals.toValue<RFLAnimationTypeEnumModel>(this)
        as String;
  }
}

