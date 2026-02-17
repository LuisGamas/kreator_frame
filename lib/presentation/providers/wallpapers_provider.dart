// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

/// Notifier that manages the wallpapers list.
/// Retrieves and caches available wallpapers from the repository.
class WallpapersNotifier extends AsyncNotifier<List<WallpaperEntity>> {
  @override
  Future<List<WallpaperEntity>> build() async {
    ref.keepAlive();
    final repository = ref.watch(repositoryProvider);
    return await repository.getListOfWallpapers();
  }
}

/// Provider that exposes the wallpapers list.
/// The state is kept in memory for the lifetime of the app.
final getWallpapersProvider = AsyncNotifierProvider<WallpapersNotifier, List<WallpaperEntity>>(
  WallpapersNotifier.new,
);
