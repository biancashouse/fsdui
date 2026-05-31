import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_button_color.dart';

class ColorOrGradientPNode extends PNode {
  UpTo6Colors? colors;
  final void Function(UpTo6Colors?) onColorChange;

  ColorOrGradientPNode({
    required this.colors,
    required this.onColorChange,
    required super.snode,
    required super.name,
  });

  @override
  void revertToOriginalValue() {
    onColorChange.call(colors = null);
  }

  @override
  Widget toPropertyNodeContents(BuildContext context) {
    
    return Tooltip(
      message: name,
      child: SizedBox(
        width: 180,
        child: Column(
          children: [
            fsdui.coloredText(name, color: Colors.white),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return PropertyButtonColor(
                          cId: '$name:1',
                          // key: GlobalKey(),
                          label: '',
                          originalColor: colors?.color1,
                          onChangeF: (Color? newColor) {
                            if (newColor != null) {
                              setState(() => onColorChange.call(
                                colors = UpTo6Colors(
                                  color1: newColor,
                                  color2: colors?.color2,
                                  color3: colors?.color3,
                                  color4: colors?.color4,
                                  color5: colors?.color5,
                                  color6: colors?.color6,
                                ),
                              ));
                            }
                          },
                           
                          calloutButtonSize: const Size(24, 24),
                        );
                      }),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return PropertyButtonColor(
                        cId: '$name:2',
                        label: '',
                        originalColor: colors?.color2,
                        onChangeF: (Color? newColor) {
                          if (newColor != null) {
                            setState(() => onColorChange.call(
                              colors = UpTo6Colors(
                                color1: colors?.color1,
                                color2: newColor,
                                color3: colors?.color3,
                                color4: colors?.color4,
                                color5: colors?.color5,
                                color6: colors?.color6,
                              ),
                            ));
                          }
                        },
                         
                        calloutButtonSize: const Size(24, 24),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return PropertyButtonColor(
                        cId: '$name:3',
                        label: '',
                        originalColor: colors?.color3,
                        onChangeF: (Color? newColor) {
                          if (newColor != null) {
                            setState(() => onColorChange.call(
                              colors = UpTo6Colors(
                                color1: colors?.color1,
                                color2: colors?.color2,
                                color3: newColor,
                                color4: colors?.color4,
                                color5: colors?.color5,
                                color6: colors?.color6,
                              ),
                            ));
                          }
                        },
                         
                        calloutButtonSize: const Size(24, 24),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return PropertyButtonColor(
                        cId: '$name:4',
                        label: '',
                        originalColor: colors?.color4,
                        onChangeF: (Color? newColor) {
                          if (newColor != null) {
                            setState(() => onColorChange.call(
                              colors = UpTo6Colors(
                                color1: colors?.color1,
                                color2: colors?.color2,
                                color3: colors?.color3,
                                color4: newColor,
                                color5: colors?.color5,
                                color6: colors?.color6,
                              ),
                            ));
                          }
                        },
                         
                        calloutButtonSize: const Size(24, 24),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return PropertyButtonColor(
                        cId: '$name:5',
                        label: '',
                        originalColor: colors?.color5,
                        onChangeF: (Color? newColor) {
                          if (newColor != null) {
                            setState(() => onColorChange.call(
                              colors = UpTo6Colors(
                                color1: colors?.color1,
                                color2: colors?.color2,
                                color3: colors?.color3,
                                color4: colors?.color4,
                                color5: newColor,
                                color6: colors?.color6,
                              ),
                            ));
                          }
                        },
                         
                        calloutButtonSize: const Size(24, 24),
                      );
                    },
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return PropertyButtonColor(
                        cId: '$name:6',
                        label: '',
                        originalColor: colors?.color6,
                        onChangeF: (Color? newColor) {
                          if (newColor != null) {
                            setState(() => onColorChange.call(
                              colors = UpTo6Colors(
                                color1: colors?.color1,
                                color2: colors?.color2,
                                color3: colors?.color3,
                                color4: colors?.color4,
                                color5: colors?.color5,
                                color6: newColor,
                              ),
                            ));
                          }
                        },
                         
                        calloutButtonSize: const Size(24, 24),
                      );
                    },
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
