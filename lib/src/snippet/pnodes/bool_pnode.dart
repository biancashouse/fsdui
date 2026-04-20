import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_button_bool.dart';

class BoolPNode extends PNode {
  bool? boolValue;
  final ValueChanged<bool?> onBoolChange;

  BoolPNode({
    required this.boolValue,
    required this.onBoolChange,
    required super.name,
    required super.snode,
  });

  @override
  void revertToOriginalValue() {
    onBoolChange(boolValue = null);
  }

  @override
  Widget toPropertyNodeContents(BuildContext context) => PropertyEditorBool(
    name: super.name,
    boolValue: boolValue ?? false,
    onChanged: (newValue) {
      onBoolChange(boolValue = newValue);
    },
  );
}
