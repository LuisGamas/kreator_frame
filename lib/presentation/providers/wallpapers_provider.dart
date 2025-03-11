// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';

part 'wallpapers_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<WallpaperEntity>> getWallpapers(Ref ref) async {
  final Repository repository = RepositoryImpl(DataSourceImpl());
  final wallpapers = await repository.getListOfWallpapers();
  return wallpapers;
}
