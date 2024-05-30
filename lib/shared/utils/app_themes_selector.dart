// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';

List<ThemeModeEntity> appThemesSelector = [
  ThemeModeEntity(
    themeMode: ThemeMode.system,
    // title: 'Sistema',
    title: 'System',
    icon: Hicon.situation2Bold,
  ),
  ThemeModeEntity(
    themeMode: ThemeMode.light,
    // title: 'Claro',
    title: 'Light',
    icon: Hicon.sun1Bold,
  ),
  ThemeModeEntity(
    themeMode: ThemeMode.dark,
    // title: 'Oscuro',
    title: 'Dark',
    icon: Hicon.moonBold,
  ),
];
