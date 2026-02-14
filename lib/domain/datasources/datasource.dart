// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';

abstract class DataSource {
  Future<AppInfoEntity> getAppInformation();
  Future<String> checkAppForUpdates();
  Future<String> executeImmediateAppUpdate();
  Future<bool> setWallpaper(String url, int location, Size size);
  Future<List<WallpaperEntity>> getListOfWallpapers();
  Future<List<WidgetEntity>> getListOfWidgets(String filesExt, String thumbName);
  Future<void> launchExternalApp(String url);
  Future<List<LicenseEntity>> getLicenses();

  /// Download a wallpaper from a URL and save it to the device gallery.
  ///
  /// Uses MediaStore API (Scoped Storage) on Android 10+ without requiring permissions.
  /// Only requires WRITE_EXTERNAL_STORAGE for Android 9 and earlier versions.
  ///
  /// Parameters:
  /// - [url]: URL of the wallpaper to download
  /// - [fileName]: Name of the file to save (without extension)
  /// - [onProgressUpdate]: Optional callback to track download progress (0.0 to 1.0)
  ///
  /// Returns [true] if the download was successful, [false] otherwise
  Future<bool> downloadWallpaper(
    String url,
    String fileName, {
    void Function(double)? onProgressUpdate,
  });
}
