// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

/// Notifier that manages the open-source licenses list.
/// Retrieves and caches OSS licenses from the repository.
class LicensesOssNotifier extends AsyncNotifier<List<LicenseEntity>> {
  @override
  Future<List<LicenseEntity>> build() async {
    ref.keepAlive();
    final repository = ref.watch(repositoryProvider);
    return await repository.getLicenses();
  }
}

/// Provider that exposes the OSS licenses list.
/// The state is kept in memory for the lifetime of the app.
final licensesOssProvider = AsyncNotifierProvider<LicensesOssNotifier, List<LicenseEntity>>(
  LicensesOssNotifier.new,
);
