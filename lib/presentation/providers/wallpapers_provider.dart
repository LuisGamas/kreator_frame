// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

/// Notifier que gestiona la lista de wallpapers.
/// Recupera y cachea los wallpapers disponibles desde el repository.
class WallpapersNotifier extends AsyncNotifier<List<WallpaperEntity>> {
  @override
  Future<List<WallpaperEntity>> build() async {
    ref.keepAlive();
    final repository = ref.watch(repositoryProvider);
    return await repository.getListOfWallpapers();
  }
}

/// Provider que expone la lista de wallpapers.
/// El estado se mantiene en memoria durante la vida de la app.
final getWallpapersProvider = AsyncNotifierProvider<WallpapersNotifier, List<WallpaperEntity>>(
  WallpapersNotifier.new,
);
