// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';

abstract class DataSource {
  Future<AppInfoEntity> getAppInformation();
  Future<bool> setWallpaper(String url, int location, Size size);
  Future<List<WallpaperEntity>> getListOfWallpapers();
  Future<List<WidgetEntity>> getListOfWidgets(String filesExt, String thumbName);
  Future<void> launchExternalApp(String url);
  Future<List<LicenseEntity>> getLicenses();
}
