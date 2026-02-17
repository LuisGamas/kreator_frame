// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

/// Notifier that manages the application information state.
/// Retrieves app data (version, build, name) from the repository.
class PackageInfoNotifier extends AsyncNotifier<AppInfoEntity> {
  @override
  Future<AppInfoEntity> build() async {
    ref.keepAlive();
    final repository = ref.watch(repositoryProvider);
    return await repository.getAppInformation();
  }
}

/// Provider that exposes the application information state.
/// The state is kept in memory for the lifetime of the app.
final packageInfoProvider = AsyncNotifierProvider<PackageInfoNotifier, AppInfoEntity>(
  PackageInfoNotifier.new,
);
