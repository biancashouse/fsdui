
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_button_color.dart';

class ColorPNode extends PNode {
  Color? color;
  final ValueChanged<Color?> onColorChange;
  final Size calloutButtonSize = const Size(120, 24);

  ColorPNode({
    required this.color,
    required this.onColorChange,
    required super.snode,
    required super.name,
    super.tooltip,
  });

  @override
  void revertToOriginalValue() {
    onColorChange.call(color = null);
  }

  @override
  Widget toPropertyNodeContents(BuildContext context) {
    
    return PropertyButtonColor(
      cId: name,
      label: name,
      tooltip: tooltip,
      originalColor: color,
      onChangeF: (Color? newColor) {
        if (newColor != null) {
          onColorChange.call(color = newColor);
        }
      },
      calloutButtonSize: calloutButtonSize,
       
    );
  }
}
