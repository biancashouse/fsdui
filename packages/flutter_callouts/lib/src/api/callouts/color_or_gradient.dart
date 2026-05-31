import 'package:flutter/material.dart';

class ColorOrGradient {
  final List<Color> colors;
  final bool isLinear;

  ColorOrGradient.gradient(
      this.colors, {
        this.isLinear = true /* always true for borders */,
      });

  ColorOrGradient.color(Color singleColor)
      : colors = [singleColor],
        isLinear = true;

  bool isAGradient() => colors.length > 1;

  bool isASingleColor() => colors.length == 1;

  bool empty() => colors.isEmpty;

  Color? get singleColor => colors.length == 1 ? colors.first : null;

  Gradient? get gradient => isAGradient()
      ? (isLinear
      ? LinearGradient(colors: colors)
      : RadialGradient(colors: colors))
      : null;

  Color? gradientColor(int i) => colors.length > i ? colors[i] : null;
}
