import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_button_string_list.dart';

class StringListPNode extends PNode {
  List<String> values;
  final ValueChanged<List<String>> onListChange;
  final Size calloutButtonSize;
  final Size calloutSize;

  StringListPNode({
    required this.values,
    required this.onListChange,
    required super.snode,
    required super.name,
    super.tooltip,
    this.calloutButtonSize = const Size(160, 24),
    this.calloutSize = const Size(320, 400),
  });

  @override
  void revertToOriginalValue() {
    onListChange.call(values = []);
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
    );
  }
}
