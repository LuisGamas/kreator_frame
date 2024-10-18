// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class ThemeModeEntity {
  final ThemeMode themeMode;
  final String Function(BuildContext) title;
  final IconData icon;

  ThemeModeEntity({
    required this.themeMode,
    required this.title,
    required this.icon
  });
}
