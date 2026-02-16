// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

/// Notifier que gestiona el estado de la información de la aplicación.
/// Recupera datos de la aplicación (versión, compilación, nombre) desde el repository.
class PackageInfoNotifier extends AsyncNotifier<AppInfoEntity> {
  @override
  Future<AppInfoEntity> build() async {
    ref.keepAlive();
    final repository = ref.watch(repositoryProvider);
    return await repository.getAppInformation();
  }
}

/// Provider que expone el estado de la información de la aplicación.
/// El estado se mantiene en memoria durante la vida de la app.
final packageInfoProvider = AsyncNotifierProvider<PackageInfoNotifier, AppInfoEntity>(
  PackageInfoNotifier.new,
);
