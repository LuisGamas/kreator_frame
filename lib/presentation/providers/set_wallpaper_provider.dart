// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier that manages wallpaper application state.
/// Controls whether a wallpaper is currently being applied.
class SetWallpaperNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  /// Toggles the wallpaper application state.
  void changeState() {
    state = !state;
  }
}

/// Provider that exposes the wallpaper application state.
final setWallpaperProvider = NotifierProvider<SetWallpaperNotifier, bool>(
  SetWallpaperNotifier.new,
);
