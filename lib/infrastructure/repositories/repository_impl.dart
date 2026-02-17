// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';

/// Implementation of the Repository interface.
///
/// This class acts as a pass-through to the DataSource, following Clean Architecture
/// principles where the repository sits between the domain and data layers. While
/// currently a simple delegation, this structure allows for:
/// - Future aggregation of multiple data sources
/// - Addition of caching logic
/// - Domain-specific data transformations
/// - Business rule enforcement
///
/// The repository receives the DataSource through dependency injection via providers.
class RepositoryImpl extends Repository {
  final DataSource dataSource;

  RepositoryImpl(this.dataSource);

  @override
  Future<AppInfoEntity> getAppInformation() {
    return dataSource.getAppInformation();
  }

  @override
  Future<String> checkAppForUpdates() {
    return dataSource.checkAppForUpdates();
  }
  
  @override
  Future<String> executeImmediateAppUpdate() {
    return dataSource.executeImmediateAppUpdate();
  }

  @override
  Future<bool> setWallpaper(String url, int location, Size size) {
    return dataSource.setWallpaper(url, location, size);
  }

  @override
  Future<List<WallpaperEntity>> getListOfWallpapers() {
    return dataSource.getListOfWallpapers();
  }
  
  @override
  Future<List<WidgetEntity>> getListOfWidgets(String filesExt, String thumbName) {
    return dataSource.getListOfWidgets(filesExt, thumbName);
  }

  @override
  Future<void> launchExternalApp(String url) {
    return dataSource.launchExternalApp(url);
  }
  
  @override
  Future<List<LicenseEntity>> getLicenses() {
    return dataSource.getLicenses();
  }

  @override
  Future<bool> downloadWallpaper(
    String url,
    String fileName, {
    void Function(double)? onProgressUpdate,
  }) {
    return dataSource.downloadWallpaper(
      url,
      fileName,
      onProgressUpdate: onProgressUpdate,
    );
  }
}
