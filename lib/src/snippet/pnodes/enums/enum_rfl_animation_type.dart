import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_button_enum.dart';
import 'package:responsive_flex_list/responsive_flex_list.dart';

part 'enum_rfl_animation_type.mapper.dart';

@MappableEnum()
enum RFLAnimationTypeEnumModel {
  none(AnimationType.none),
  fade(AnimationType.fade),
  scale(AnimationType.scale),
  slide(AnimationType.slide),
  slideUp(AnimationType.slideUp),
  slideDown(AnimationType.slideDown),
  rotation(AnimationType.rotation),
  bounce(AnimationType.bounce),
  flipIn(AnimationType.flipIn);

  const RFLAnimationTypeEnumModel(this.flutterValue);

  final AnimationType flutterValue;

  String toSource() => 'AnimationType.$name';

  static Widget propertyNodeContents({
    int? enumValueIndex,
    required SNode snode,
    required String label,
    ValueChanged<int?>? onChangedF,
  }) =>
      PropertyButtonEnum(
        label: label,
        menuItems: values.map((e) => e.toMenuItem()).toList(),
        originalEnumIndex: enumValueIndex,
        onChangeF: (newIndex) => onChangedF?.call(newIndex),
        wrap: true,
        calloutButtonSize: const Size(110, 30),
        calloutSize: const Size(280, 200),
      );

  Widget toMenuItem() => fsdui.coloredText(name, color: Colors.white);

  static RFLAnimationTypeEnumModel? of(int? index) =>
      index != null ? RFLAnimationTypeEnumModel.values.elementAtOrNull(index) : null;
}
