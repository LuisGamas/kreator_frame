// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que gestiona el estado de aplicación del wallpaper.
/// Controla si un wallpaper se está aplicando actualmente.
class SetWallpaperNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  /// Alterna el estado de aplicación del wallpaper.
  void changeState() {
    state = !state;
  }
}

/// Provider que expone el estado de aplicación del wallpaper.
final setWallpaperProvider = NotifierProvider<SetWallpaperNotifier, bool>(
  SetWallpaperNotifier.new,
);
