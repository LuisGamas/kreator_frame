// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';

List<ThemeModeEntity> appThemesSelector = [
  ThemeModeEntity(
    themeMode: ThemeMode.system,
    title: (context) => AppLocalizations.of(context)!.themeSystem,
    icon: Hicon.situation2Bold,
  ),
  ThemeModeEntity(
    themeMode: ThemeMode.light,
    title: (context) => AppLocalizations.of(context)!.themeLight,
    icon: Hicon.sun1Bold,
  ),
  ThemeModeEntity(
    themeMode: ThemeMode.dark,
    title: (context) => AppLocalizations.of(context)!.themeDark,
    icon: Hicon.moonBold,
  ),
];
