import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_callout_button_T.dart';

class IntPNode extends PNode {
  int? intValue;
  final ValueChanged<int?> onIntChange;
  final bool viaButton;
  final Size calloutButtonSize;

  // final Size calloutSize;

  IntPNode({
    required this.intValue,
    required this.onIntChange,
    required super.snode,
    required super.name,
    this.viaButton = false,
    required this.calloutButtonSize,
    // required this.calloutSize,
  });

  @override
  void revertToOriginalValue() {
    onIntChange(intValue = null);
  }

  @override
  Widget toPropertyNodeContents(BuildContext context) {
    
    return PropertyButton<int>(
      originalText: intValue != null ? intValue.toString() : '',
      label: super.name,
      skipHelperText: true,
      calloutButtonSize: calloutButtonSize,
      calloutSize: const Size(120, 100),
      propertyBtnGK: GlobalKey(debugLabel: 'int'),
      onChangeF: (s) {
        onIntChange.call(intValue = int.tryParse(s));
      },
       
    );
  }
}
