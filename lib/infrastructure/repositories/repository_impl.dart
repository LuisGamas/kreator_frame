// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';

class RepositoryImpl extends Repository {

  final DataSource dataSource;

  RepositoryImpl(this.dataSource);

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
  FutureBuilder<String> getOfficialData(String nameFolder, String nameFile) {
    return dataSource.getOfficialData(nameFolder, nameFile);
  }

}
