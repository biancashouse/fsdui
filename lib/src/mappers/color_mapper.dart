import 'package:flutter/material.dart';
import 'package:dart_mappable/dart_mappable.dart';

class ColorMapper extends SimpleMapper<Color> {
  const ColorMapper();

  @override
  Color decode(dynamic value) {
    if (value is String) {
      // Remove '#' if it exists and parse as an integer
      final hex = value.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    }
    // Return transparent black as a safe fallback
    return const Color(0x00000000);
  }

  @override
  dynamic encode(Color object) {
    // Convert the color to a hex string (e.g., #RRGGBB)
    return '#${object.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}
