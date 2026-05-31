import 'package:flutter/material.dart';
import 'package:dart_mappable/dart_mappable.dart';

class ThemeModeMapper extends SimpleMapper<ThemeMode> {
  const ThemeModeMapper();

  @override
  ThemeMode decode(dynamic value) {
    if (value is int) {
      return ThemeMode.values[value];
    }
    // Return transparent black as a safe fallback
    return ThemeMode.system;
  }

  @override
  dynamic encode(ThemeMode object) {
    // Convert the ThemeMode to its enum index
    final index = ThemeMode.values.indexOf(object);
    return index == -1
        ? ThemeMode.system
        : index;
  }
}
