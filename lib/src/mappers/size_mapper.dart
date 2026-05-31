import 'package:flutter/material.dart';
import 'package:dart_mappable/dart_mappable.dart';

class SizeMapper extends SimpleMapper<Size> {
  const SizeMapper();

  @override
  Size decode(dynamic value) {
    if (value is Map) {
      double w = (value['w'] as num?)?.toDouble() ?? double.infinity;
      double h = (value['h'] as num?)?.toDouble() ?? double.infinity;
      return Size(w,h);
    }
    return Size.zero;
  }

  @override
  dynamic encode(Size object) {
    return {'w': object.width, 'h': object.height};
  }
}
