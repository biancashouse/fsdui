import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/color_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/groups/border_side_properties.dart';

class BorderSidePNode /*Group*/ extends PNode /*Group*/ {
  BorderSideProperties? borderSideGroup;
  final ValueChanged<BorderSideProperties> onGroupChange;

  BorderSidePNode /*Group*/ ({
    required super.name,
    required this.borderSideGroup,
    required this.onGroupChange,
    required super.snode,
    super.children = const [],
  }) {
    super.children = [
      DecimalPNode(
        snode: super.snode,
        name: 'width',
        decimalValue: borderSideGroup?.width,
        onDoubleChange: (newValue) {
          borderSideGroup ??= BorderSideProperties();
          borderSideGroup!.width = newValue;
          onGroupChange.call(borderSideGroup!);
        },
        calloutButtonSize: const Size(72, 30),
      ),
      ColorPNode(
        snode: super.snode,
        name: 'color',
        color: borderSideGroup?.color,
        onColorChange: (newValue) {
          borderSideGroup ??= BorderSideProperties();
          borderSideGroup!.color = newValue;
          onGroupChange.call(borderSideGroup!);
        },
      ),
    ];
  }
}
