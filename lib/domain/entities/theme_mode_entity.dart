// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// Entity representing a theme mode option.
/// Contains a theme mode with its localized title and icon representation.
class ThemeModeEntity {
  final ThemeMode themeMode;
  final String Function(BuildContext) title;
  final IconData icon;

  ThemeModeEntity({
    required this.themeMode,
    required this.title,
    required this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModeEntity && other.themeMode == themeMode;

  @override
  int get hashCode => themeMode.hashCode;
}
