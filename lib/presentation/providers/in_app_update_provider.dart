// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

// * STATE
class InAppUpdateState {
  final bool canExecuteUpdate;
  final bool hasLaunchedUpdate;

  InAppUpdateState({
    this.canExecuteUpdate = false,
    this.hasLaunchedUpdate = false,
  });

  InAppUpdateState copyWith({
    bool? canExecuteUpdate,
    bool? hasLaunchedUpdate,
  }) => InAppUpdateState(
    canExecuteUpdate: canExecuteUpdate ?? this.canExecuteUpdate,
    hasLaunchedUpdate: hasLaunchedUpdate ?? this.hasLaunchedUpdate,
  );
}

// * NOTIFIER
class InAppUpdateNotifier extends Notifier<InAppUpdateState> {
  @override
  InAppUpdateState build() {
    return InAppUpdateState();
  }

  /// Verifica si hay actualizaciones disponibles para la aplicación.
  /// Actualiza el estado con el resultado de la verificación.
  Future<void> checkAppForUpdates() async {
    try {
      if (state.hasLaunchedUpdate) return;

      final repository = ref.read(repositoryProvider);
      final resultOfReviewingUpdates = await repository.checkAppForUpdates();

      state = state.copyWith(
        canExecuteUpdate: resultOfReviewingUpdates == 'updateAvailable',
        hasLaunchedUpdate: resultOfReviewingUpdates == 'recovered',
      );
    } catch (e) {
      state = state.copyWith(
        canExecuteUpdate: false,
        hasLaunchedUpdate: false,
      );
    }
  }

  /// Ejecuta la actualización inmediata de la aplicación.
  /// Solo se puede ejecutar si hay una actualización disponible.
  Future<void> executeImmediateAppUpdate() async {
    try {
      final repository = ref.read(repositoryProvider);
      final resultOfReviewingUpdates = await repository.executeImmediateAppUpdate();

      state = state.copyWith(
        canExecuteUpdate: resultOfReviewingUpdates == 'upToDate' ? false : state.canExecuteUpdate,
        hasLaunchedUpdate: resultOfReviewingUpdates == 'upToDate',
      );
    } catch (e) {
      state = state.copyWith(
        canExecuteUpdate: false,
        hasLaunchedUpdate: false,
      );
    }
  }
}

// * PROVIDER
final inAppUpdateProvider = NotifierProvider<InAppUpdateNotifier, InAppUpdateState>(
  InAppUpdateNotifier.new,
);
