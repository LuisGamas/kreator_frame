// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/shared/services/services.dart';
import 'package:kreator_frame/shared/utils/utils.dart';

part 'app_color_theme_provider.g.dart';

@riverpod
class AppColorTheme extends _$AppColorTheme {
  final KeyValueStorageService storageService = KeyValueStorageServieceImpl();

  @override
  Color build() {
    return AppThemeColors.primaryColor.first;
  }

  void setColorTheme(Color color) async {
    state = color;
    final colorIndex = AppThemeColors.primaryColor.indexOf(color);
    await storageService.setKeyValue(Environment.keyColorTheme, colorIndex);
  }

  void updateColorTheme() async {
    final colorIndex = await storageService.getKeyValue<int>(Environment.keyColorTheme);
    if (colorIndex != null && colorIndex >= 0 && colorIndex < AppThemeColors.primaryColor.length) {
      state = AppThemeColors.primaryColor[colorIndex];
    }
  }
  
}
