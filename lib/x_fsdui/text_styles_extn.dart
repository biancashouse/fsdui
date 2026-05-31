import 'package:flutter/material.dart' show Colors;
import 'package:fsdui/fsdui.dart';

extension TextStylesExtension on FSDUI_Mixins {
  Map<TextStyleName, TextStyleProperties> cannedTextStyles() => {
    "white14":
    TextStyleProperties(color: Colors.white, fontSize: 14),
    "white18":
    TextStyleProperties(color: Colors.white, fontSize: 18),
    "white24":
    TextStyleProperties(color: Colors.white, fontSize: 24),
    "white28":
    TextStyleProperties(color: Colors.white, fontSize: 28),
    "white30":
    TextStyleProperties(color: Colors.white, fontSize: 30),
    "white36":
    TextStyleProperties(color: Colors.white, fontSize: 36),
    "black14":
    TextStyleProperties(color: Colors.black, fontSize: 14),
    "black18":
    TextStyleProperties(color: Colors.black, fontSize: 18),
    "black24":
    TextStyleProperties(color: Colors.black, fontSize: 24),
    "black28":
    TextStyleProperties(color: Colors.black, fontSize: 28),
    "black30":
    TextStyleProperties(color: Colors.black, fontSize: 30),
    "black36":
    TextStyleProperties(color: Colors.black, fontSize: 36),
    "blue14":
    TextStyleProperties(color: Colors.blue, fontSize: 14),
    "blue18":
    TextStyleProperties(color: Colors.blue, fontSize: 18),
    "blue24":
    TextStyleProperties(color: Colors.blue, fontSize: 24),
    "blue28":
    TextStyleProperties(color: Colors.blue, fontSize: 28),
    "blue30":
    TextStyleProperties(color: Colors.blue, fontSize: 30),
    "blue36":
    TextStyleProperties(color: Colors.blue, fontSize: 36),
  };

  /// inspect the named text styles for a match, and return the name of that matching style
  TextStyleName? findTextStyleName(AppInfoModel appInfo, TextStyleProperties props) {
    for (TextStyleName tsName in appInfo.textStyles.keys) {
      TextStyleProperties namedTSProps = appInfo.textStyles[tsName]!;
      if (namedTSProps.color == props.color &&
          namedTSProps.fontWeight == props.fontWeight &&
          namedTSProps.fontSize == props.fontSize &&
          namedTSProps.fontSizeName == props.fontSizeName &&
          namedTSProps.fontFamily == props.fontFamily &&
          namedTSProps.fontStyle == props.fontStyle &&
          namedTSProps.letterSpacing == props.letterSpacing &&
          namedTSProps.lineHeight == props.lineHeight) {
        return tsName;
      }
    }
    return null;
  }
}