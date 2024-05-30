// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class AppTheme {
  final Color? primaryColor;

  AppTheme({
    required this.primaryColor,
  });

  // * Returns a light theme based on the primary color.
  ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: primaryColor,
    );
  }

  // * Returns a dark theme based on the primary color.
  ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: primaryColor,
    );
  }
}
