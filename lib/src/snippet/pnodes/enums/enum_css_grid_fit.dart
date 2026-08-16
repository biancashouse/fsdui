import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_button_enum.dart';

part 'enum_css_grid_fit.mapper.dart';

@MappableEnum()
enum CSSGridFitEnumModel {
  expand(GridFit.expand),
  loose(GridFit.loose),
  passthrough(GridFit.passthrough);

  const CSSGridFitEnumModel(this.flutterValue);

  final GridFit flutterValue;

  String toSource() => 'GridFit.$name';

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
        calloutSize: const Size(280, 120),
      );

  Widget toMenuItem() => fsdui.coloredText(name, color: Colors.white);

  static CSSGridFitEnumModel? of(int? index) =>
      index != null ? CSSGridFitEnumModel.values.elementAtOrNull(index) : null;
}
