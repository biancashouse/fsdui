import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_button_string_list.dart';

class StringListPNode extends PNode {
  List<String> values;
  final ValueChanged<List<String>> onListChange;
  final Size calloutButtonSize;
  final Size calloutSize;

  // When provided, rows/the add button pick from this fixed set of values
  // (e.g. page snippet names) instead of free-text entry.
  final List<String>? options;

  // When provided, each row also shows a free-text field for a value paired
  // 1:1 (by index) with `values` — e.g. a display title for each picked
  // page snippet name.
  List<String>? secondaryValues;
  final ValueChanged<List<String>>? onSecondaryListChange;
  final String? secondaryHintText;

  StringListPNode({
    required this.values,
    required this.onListChange,
    required super.snode,
    required super.name,
    super.tooltip,
    this.calloutButtonSize = const Size(160, 24),
    this.calloutSize = const Size(320, 400),
    this.options,
    this.secondaryValues,
    this.onSecondaryListChange,
    this.secondaryHintText,
  });

  @override
  void revertToOriginalValue() {
    onListChange.call(values = []);
    if (onSecondaryListChange != null) {
      onSecondaryListChange!.call(secondaryValues = []);
    }
  }

  @override
  Widget toPropertyNodeContents(BuildContext context) {
    return PropertyButtonStringList(
      cId: name,
      label: name,
      tooltip: tooltip,
      values: values,
      onChangeF: (newValues) => onListChange.call(values = newValues),
      calloutButtonSize: calloutButtonSize,
      calloutSize: calloutSize,
      options: options,
      secondaryValues: secondaryValues,
      onSecondaryChangeF: onSecondaryListChange != null
          ? (newValues) =>
              onSecondaryListChange!.call(secondaryValues = newValues)
          : null,
      secondaryHintText: secondaryHintText,
    );
  }
}
