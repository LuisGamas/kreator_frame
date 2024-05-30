// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'set_wallpaper_provider.g.dart';

@riverpod
class SetWallpaper extends _$SetWallpaper {
  @override
  bool build() {
    return false;
  }

  void changeState() {
    state = !state;
  }
}
