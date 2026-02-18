// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier that manages wallpaper download progress.
/// Allows updating progress from 0.0 to 1.0 during a download.
class ProgressDownloaderNotifier extends Notifier<double?> {
  @override
  double? build() => 0;

  /// Updates the current download progress.
  /// Values: null (inactive), 0 (started), 0.0-1.0 (progress), 1.0 (completed).
  void changeProgress(double? progress) {
    state = progress;
  }
}

/// Provider that exposes the wallpaper download progress state.
final progressDownloaderProvider = NotifierProvider<ProgressDownloaderNotifier, double?>(
  ProgressDownloaderNotifier.new,
);
