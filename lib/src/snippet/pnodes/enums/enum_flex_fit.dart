// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/flexfit_editor.dart';

part 'enum_flex_fit.mapper.dart';

@MappableEnum()
enum FlexFitEnum  {
  tight(FlexFit.tight),
  loose(FlexFit.loose);

  const FlexFitEnum(this.flutterValue);

  final FlexFit flutterValue;

  String toSource() => 'FlexFit.$name';


  static Widget propertyNodeContents({
    int? enumValueIndex,
    required SNode snode,
    required String label,
    ValueChanged<int?>? onChangedF,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlexFitEditor(
            originalValue: FlexFitEnum.of(enumValueIndex),
            onChangedF: (FlexFitEnum? newValue) {onChangedF?.call(newValue?.index);},
        ),
      );

  Widget toMenuItem() => fsdui.coloredText(name, color: Colors.white);

  static FlexFitEnum? of(int? index) => index != null ? FlexFitEnum.values.elementAtOrNull(index) : null;
}
