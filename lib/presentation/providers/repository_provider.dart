// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';

part 'repository_provider.g.dart';

@riverpod
Repository repository(Ref ref) {
  return RepositoryImpl(DataSourceImpl());
}
