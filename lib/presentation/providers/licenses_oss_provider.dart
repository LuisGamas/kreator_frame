// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

/// Notifier que gestiona la lista de licencias de código abierto.
/// Recupera y cachea las licencias OSS desde el repository.
class LicensesOssNotifier extends AsyncNotifier<List<LicenseEntity>> {
  @override
  Future<List<LicenseEntity>> build() async {
    ref.keepAlive();
    final repository = ref.watch(repositoryProvider);
    return await repository.getLicenses();
  }
}

/// Provider que expone la lista de licencias OSS.
/// El estado se mantiene en memoria durante la vida de la app.
final licensesOssProvider = AsyncNotifierProvider<LicensesOssNotifier, List<LicenseEntity>>(
  LicensesOssNotifier.new,
);
