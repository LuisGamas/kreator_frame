// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final Color primaryColor;

  AppTheme({required this.primaryColor});

  late final ThemeData lightTheme = _buildTheme(Brightness.light);
  late final ThemeData darkTheme = _buildTheme(Brightness.dark);

  ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(colorScheme),
    );
  }

  static ThemeData buildFromColorScheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(colorScheme),
    );
  }

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final baseTheme = colorScheme.brightness == Brightness.light 
      ? Typography.material2021().black 
      : Typography.material2021().white;
    final headsThemes = GoogleFonts.googleSansTextTheme(baseTheme);
    final bodysThemes = GoogleFonts.robotoFlexTextTheme(baseTheme);

    return baseTheme.copyWith(
      displayLarge: headsThemes.displayLarge,
      displayMedium: headsThemes.displayMedium,
      displaySmall: headsThemes.displaySmall,
      headlineLarge: headsThemes.headlineLarge,
      headlineMedium: headsThemes.headlineMedium,
      headlineSmall: headsThemes.headlineSmall,
      titleLarge: headsThemes.titleLarge,
      titleMedium: headsThemes.titleMedium,
      titleSmall: headsThemes.titleSmall,
      bodyLarge: bodysThemes.bodyLarge,
      bodyMedium: bodysThemes.bodyMedium,
      bodySmall: bodysThemes.bodySmall,
      labelLarge: bodysThemes.labelLarge,
      labelMedium: bodysThemes.labelMedium,
      labelSmall: bodysThemes.labelSmall,
    ).apply(
      displayColor: colorScheme.onSurface,
      bodyColor: colorScheme.onSurface,
    );
  }
} 
