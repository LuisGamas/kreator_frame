// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/shared/services/services.dart';
import 'package:kreator_frame/shared/utils/utils.dart';

part 'app_theme_mode_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  
  final KeyValueStorageService storageService = KeyValueStorageServieceImpl();

  @override
  ThemeMode build() {
    _updateThemeFromStorage();
    return appThemesSelector[0].themeMode;
  }

  void setSelectedThemeMode(ThemeMode themeMode) async {
    state = themeMode;
    await storageService.setKeyValue(Environment.keyThemeMode, state.name);
  }

  void _updateThemeFromStorage() async{
    final themeFromStorage = await storageService.getKeyValue<String>(Environment.keyThemeMode);

    if (themeFromStorage != null) {
      switch (themeFromStorage) {
        case 'system':
          state = appThemesSelector[0].themeMode;
          break;
        case 'light':
          state = appThemesSelector[1].themeMode;
          break;
        case 'dark':
          state = appThemesSelector[2].themeMode;
          break;
        default:
      }
    } 
  }

}
