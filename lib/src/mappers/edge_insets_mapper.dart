import 'package:flutter/material.dart';
import 'package:dart_mappable/dart_mappable.dart';

class EdgeInsetsMapper extends SimpleMapper<EdgeInsets> {
  const EdgeInsetsMapper();

  @override
  EdgeInsets decode(dynamic value) {
    if (value is Map) {
      final l = (value['l'] as num?)?.toDouble() ?? 0.0;
      final t = (value['t'] as num?)?.toDouble() ?? 0.0;
      final r = (value['r'] as num?)?.toDouble() ?? 0.0;
      final b = (value['b'] as num?)?.toDouble() ?? 0.0;
      return EdgeInsets.fromLTRB(l, t, r, b);
    }
    return EdgeInsets.zero;
  }

  @override
  dynamic encode(EdgeInsets object) {
    return {'l': object.left, 't': object.top, 'r': object.right, 'b': object.bottom};
  }
}
