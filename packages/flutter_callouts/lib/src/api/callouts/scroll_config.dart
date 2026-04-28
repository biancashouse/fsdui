import 'package:flutter/material.dart';

class ScrollConfig {
  final ScrollController? sc;
  final Axis? scrollDirection;

  ScrollConfig(this.sc, this.scrollDirection);

  ScrollController? get controller => sc;

  Axis? get direction => scrollDirection;

  double get scrollOffset => sc?.offset ?? 0.0;
 }
