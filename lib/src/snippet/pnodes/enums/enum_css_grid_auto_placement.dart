import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_button_enum.dart';

part 'enum_css_grid_auto_placement.mapper.dart';

@MappableEnum()
enum CSSGridAutoPlacementEnumModel {
  rowSparse(AutoPlacement.rowSparse),
  rowDense(AutoPlacement.rowDense),
  columnSparse(AutoPlacement.columnSparse),
  columnDense(AutoPlacement.columnDense);

  const CSSGridAutoPlacementEnumModel(this.flutterValue);

  final AutoPlacement flutterValue;

  String toSource() => 'AutoPlacement.$name';

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
        calloutSize: const Size(280, 160),
      );

  Widget toMenuItem() => fsdui.coloredText(name, color: Colors.white);

  static CSSGridAutoPlacementEnumModel? of(int? index) => index != null
      ? CSSGridAutoPlacementEnumModel.values.elementAtOrNull(index)
      : null;
}
