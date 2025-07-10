// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';

part 'wallpapers_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<WallpaperEntity>> getWallpapers(Ref ref) async {
  final repository = ref.watch(repositoryProvider);
  final wallpapers = await repository.getListOfWallpapers();
  return wallpapers;
}
