// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/constants/environment.dart';
import 'package:kreator_frame/shared/services/services.dart';
import 'package:kreator_frame/shared/utils/utils.dart';

// * STATE
/// State that holds user preferences for app appearance and behavior.
///
/// Stores:
/// - Theme mode (light, dark, system)
/// - Accent color for the theme
/// - Grid view preferences (currently unused)
class AppValuesPreferencesState {
  final Color colorAccentForTheme;
  final ThemeMode themeModeForApp;
  final bool minimalViewForGrids;

  AppValuesPreferencesState({
    Color? colorAccentForTheme,
    ThemeMode? themeModeForApp,
    this.minimalViewForGrids = false,
  })  : colorAccentForTheme = colorAccentForTheme ?? AppConstants.accentColors[4],
        themeModeForApp = themeModeForApp ?? AppConstants.themeModeOptions[0].themeMode;

  AppValuesPreferencesState copyWith({
    Color? colorAccentForTheme,
    ThemeMode? themeModeForApp,
    bool? minimalViewForGrids,
  }) => AppValuesPreferencesState(
    colorAccentForTheme: colorAccentForTheme ?? this.colorAccentForTheme,
    themeModeForApp: themeModeForApp ?? this.themeModeForApp,
    minimalViewForGrids: minimalViewForGrids ?? this.minimalViewForGrids,
  );

}

// * NOTIFIER
/// Notifier that manages user preferences for app appearance.
///
/// Loads preferences from persistent storage on initialization and provides
/// methods to update theme mode and accent color. All changes are automatically
/// persisted to SharedPreferences.
class AppValuesPreferencesNotifier extends Notifier<AppValuesPreferencesState> {
  late final KeyValueStorageServices _keyValueStorageServices;

  @override
  AppValuesPreferencesState build() {
    _keyValueStorageServices = KeyValueStorageServicesImpl();
    _updateStateFromPreferences();
    return AppValuesPreferencesState();
  }
  
  void _updateStateFromPreferences() async {
    final indexColorAccent = await _keyValueStorageServices.getKeyValue<int>(Environment.keyColorTheme) ?? 4;
    final indexThemeMode = await _keyValueStorageServices.getKeyValue<String>(Environment.keyThemeMode);
    // final showMinimalGridView = await keyValueStorageServices.getKeyValue<bool>(Environment.keyMinimalGrid);

    final themeMode = switch (indexThemeMode) {
      'system' => AppConstants.themeModeOptions[0].themeMode,
      'light' => AppConstants.themeModeOptions[1].themeMode,
      'dark' => AppConstants.themeModeOptions[2].themeMode,
      _ => ThemeMode.system,
    };

    state = state.copyWith(
      colorAccentForTheme: AppConstants.accentColors[
        (indexColorAccent >= 0 && indexColorAccent < AppConstants.accentColors.length)
        ? indexColorAccent
        : 4 ],
      themeModeForApp: themeMode,
      // minimalViewForGrids: showMinimalGridView ?? false,
    );
  }

  void setPreferenceForThemeMode(ThemeMode themeMode) async {
    await _keyValueStorageServices.setKeyValue(Environment.keyThemeMode, themeMode.name);
    if (themeMode != state.themeModeForApp) {
      state = state.copyWith(
        themeModeForApp: themeMode
      );
    }
  }

  void setPreferenceForColorAccent(Color color) async {
    if (color != state.colorAccentForTheme) {
      final colorIndex = AppConstants.accentColors.indexOf(color);
      await _keyValueStorageServices.setKeyValue(Environment.keyColorTheme, colorIndex);
      state = state.copyWith(
        colorAccentForTheme: color
      );
    }
  }

  /* void toggleMinimalViewForGrids() async {
    final newValueForMinimalGrids = !state.minimalViewForGrids;
    await keyValueStorageServices.setKeyValue(Environment.keyMinimalGrid, newValueForMinimalGrids);
    state = state.copyWith(minimalViewForGrids: newValueForMinimalGrids);
  } */


}

// * PROVIDER
/// Provider that exposes user preference state and management functionality.
/// The state persists across app restarts using SharedPreferences.
final appValuesPreferencesProvider = NotifierProvider<AppValuesPreferencesNotifier, AppValuesPreferencesState>(
  AppValuesPreferencesNotifier.new,
);
