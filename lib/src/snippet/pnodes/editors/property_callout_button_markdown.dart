import 'package:flutter/material.dart';

import 'package:fsdui/fsdui.dart';

import 'markdown_msv.dart';

class PropertyButtonMarkdown extends StatelessWidget {
  final String originalMarkdown;
  final String? label;
  final Size calloutButtonSize;
  final ValueChanged<String> onChangeF;

  const PropertyButtonMarkdown({
    required this.originalMarkdown,
    this.label,
    required this.calloutButtonSize,
    required this.onChangeF,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
            onTap: () {
              showMarkdownEditor(originalMarkdown, onChangeF);
            },
            child: fsdui.coloredText('tap here to edit the markdown', color: Colors.white),
            // child: Container(
            //   alignment: Alignment.topLeft,
            //   key: widget.propertyBtnGK,
            //   width: widget.calloutButtonSize.width,
            //   height: widget.calloutButtonSize.height,
            //   child: labelWidget,
            // ),
          );
  }

  static void showMarkdownEditor(String originalMarkdown, ValueChanged<String> onChangeF) {
  CalloutConfig teCC = CalloutConfig(
    cId: 'markdown-te',
    
    // containsTextField: true,
    barrier: CalloutBarrierConfig(
        opacity: .25,
        onTappedF: () {
          fsdui.dismiss('markdown-te');
        }),
    decorationFillColors: ColorOrGradient.color(Colors.purpleAccent),
    initialCalloutW: fsdui.scrW * .8,
    initialCalloutH: fsdui.scrH * .8,
    onDismissedF: () {},
    onAcceptedF: () {},
    resizeableH: true,
    resizeableV: true,
    onResizeF: (Size newSize) {},
    onDragF: (Offset newOffset) {},
    draggable: false,
  );

  Widget calloutContent = MarkdownMSV(
    originalMD: originalMarkdown,
    onChangeF: onChangeF,
  );

  fsdui.showOverlay(
  calloutConfig: teCC,
  calloutContent: calloutContent,
  );

}
}