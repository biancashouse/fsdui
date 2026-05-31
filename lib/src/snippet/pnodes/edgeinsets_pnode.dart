import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/edge_insets_editor.dart';

class EdgeInsetsPNode extends PNode {
  EdgeInsets? ei;
  final ValueChanged<EdgeInsets?> onEIChangedF;

  EdgeInsetsPNode({
    required super.name,
    this.ei,
    required this.onEIChangedF,
    required super.snode,
  });

  @override
  void revertToOriginalValue() {
    onEIChangedF(ei = null);
  }

  @override
  Widget toPropertyNodeContents(BuildContext context) {
    return EdgeInsetsPropertyEditor(
      name: name,
      originalValue: ei,
      onChangedF: (EdgeInsets? newEI) {
        onEIChangedF.call(ei = newEI);
      },
    );
  }
}
