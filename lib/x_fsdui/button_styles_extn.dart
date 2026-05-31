import 'package:flutter/material.dart' show Colors;
import 'package:fsdui/fsdui.dart';

extension ButtonStylesExtension on FSDUI_Mixins {
  Map<ButtonStyleName, ButtonStyleProperties> cannedButtonStyles() => {
    "yellowOnBlack": ButtonStyleProperties(
      tsPropGroup: TextStyleProperties(),
      fgColor: Colors.yellow,
      bgColor: Colors.black,
      padding: 10,
      elevation: 6,
    ),
    "blackOnWhite": ButtonStyleProperties(
      tsPropGroup: TextStyleProperties(),
      fgColor: Colors.black,
      bgColor: Colors.white,
      padding: 10,
      elevation: 6,
    ),
  };

  ButtonStyleName? findButtonStyleName(AppInfoModel appInfop, ButtonStyleProperties props) {
    for (ButtonStyleName bsName in appInfo.buttonStyles.keys) {
      ButtonStyleProperties namedBSProps = appInfo.buttonStyles[bsName]!;
      if (namedBSProps.bgColor == props.bgColor &&
          namedBSProps.fgColor == props.fgColor &&
          namedBSProps.tsPropGroup == props.tsPropGroup &&
          namedBSProps.elevation == props.elevation &&
          namedBSProps.padding == props.padding &&
          namedBSProps.shape == props.shape &&
          namedBSProps.fixedH == props.fixedH &&
          namedBSProps.fixedW == props.fixedW &&
          namedBSProps.maxH == props.maxH &&
          namedBSProps.maxW == props.maxW &&
          namedBSProps.minH == props.minW &&
          namedBSProps.maxH == props.maxW &&
          namedBSProps.radius == props.radius &&
          namedBSProps.side?.color == props.side?.color &&
          namedBSProps.side?.width == props.side?.width) {
        return bsName;
      }
    }
    return null;
  }

}
