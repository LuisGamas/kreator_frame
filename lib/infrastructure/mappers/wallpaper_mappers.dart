// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';

class WallpaperMapper {
  static WallpaperEntity wallpapersToEntity(Wallpaper wallpaper) =>
    WallpaperEntity(
      name: wallpaper.name,
      author: wallpaper.author,
      url: wallpaper.url,
      copyright: wallpaper.copyright,
    );
}
