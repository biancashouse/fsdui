import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_button_fs_browser.dart';

class FSImagePathPNode extends PNode {
  String? stringValue;
  final ValueChanged<String?> onPathChange;
  final Size calloutButtonSize;

  FSImagePathPNode({
    required this.stringValue,
    required this.onPathChange,
    required super.snode,
    required super.name,
    super.tooltip,
    this.calloutButtonSize = const Size(120, 20),
  });

  @override
  void revertToOriginalValue() {
    onPathChange.call(stringValue = null);
  }

  @override
  Widget toPropertyNodeContents(BuildContext context) {
    
    return PropertyButtonFSBrowser(
      label: name,
      tooltip: tooltip,
      originalFSPath: stringValue,
      onChangeF: (String? newPath) {
        if (newPath != null) {
          onPathChange.call(stringValue = newPath);
        }
      },
       
      calloutButtonSize: calloutButtonSize,
    );
  }
}
