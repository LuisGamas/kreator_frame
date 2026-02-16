// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que gestiona el progreso de descarga del wallpaper.
/// Permite actualizar el progreso de 0.0 a 1.0 durante una descarga.
class ProgressDownloaderNotifier extends Notifier<double?> {
  @override
  double? build() => 0;

  /// Actualiza el progreso actual de la descarga.
  /// Valores: null (inactivo), 0 (iniciado), 0.0-1.0 (progreso), 1.0 (completado).
  void changeProgress(double? progress) {
    state = progress;
  }
}

/// Provider que expone el estado del progreso de descarga del wallpaper.
final progressDownloaderProvider = NotifierProvider<ProgressDownloaderNotifier, double?>(
  ProgressDownloaderNotifier.new,
);
