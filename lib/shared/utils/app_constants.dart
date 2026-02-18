// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';

/// Application-wide constants and configuration values.
/// Centralized constants for colors, theme options, and other immutable values.
class AppConstants {
  AppConstants._();

  /// List of available accent colors for app theming.
  /// Uses Material Design color palette accents.
  static const List<Color> accentColors = [
    Color(0xFFE53935), // red
    Color(0xFFD81B60), // pink
    Color(0xFF8E24AA), // purple
    Color(0xFF5E35B1), // deep purple
    Color(0xFF3949AB), // indigo
    Color(0xFF1E88E5), // blue
    Color(0xFF039BE5), // light blue
    Color(0xFF00ACC1), // cyan
    Color(0xFF00897B), // teal
    Color(0xFF43A047), // green
    Color(0xFF7CB342), // light green
    Color(0xFFC0CA33), // lime
    Color(0xFFFDD835), // yellow
    Color(0xFFFFB300), // amber
    Color(0xFFFB8C00), // orange
    Color(0xFFF4511E), // deep orange
    Color(0xFF6D4C41), // brown
    Color(0xFF546E7A), // blue grey
    Color(0xFF455A64), // neutral dark
    Color(0xFF607D8B), // neutral light
  ];

  /// List of available theme mode options.
  /// Includes System, Light, and Dark theme modes with localized labels and icons.
  static final List<ThemeModeEntity> themeModeOptions = [
    ThemeModeEntity(
      themeMode: ThemeMode.system,
      title: (context) => AppLocalizations.of(context)!.themeSystem,
      icon: Hicon.situation2Outline,
    ),
    ThemeModeEntity(
      themeMode: ThemeMode.light,
      title: (context) => AppLocalizations.of(context)!.themeLight,
      icon: Hicon.sun1Outline,
    ),
    ThemeModeEntity(
      themeMode: ThemeMode.dark,
      title: (context) => AppLocalizations.of(context)!.themeDark,
      icon: Hicon.moonOutline,
    ),
  ];
}
