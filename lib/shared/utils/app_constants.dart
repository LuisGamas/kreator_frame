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
  static const List<Color> accentColors = Colors.accents;

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
