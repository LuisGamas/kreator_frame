// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

// 🌎 Project imports:

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
class InAppUpdateNotifier extends StateNotifier<InAppUpdateState> {
  final Repository repository;
  
  InAppUpdateNotifier({
    required this.repository,
  }) : super(InAppUpdateState());

  Future<void> checkAppForUpdates() async {
    try {
      if (state.hasLaunchedUpdate) return;

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

  Future<void> executeImmediateAppUpdate() async {
    try {
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
final inAppUpdateProvider = StateNotifierProvider<InAppUpdateNotifier, InAppUpdateState>((ref) {
  final repository = ref.watch(repositoryProvider);

  return InAppUpdateNotifier(
    repository: repository
  );
});
