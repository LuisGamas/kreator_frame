// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';

/// Provider for the application's DataSource.
/// Responsible for instantiating the DataSource implementation.
final dataSourceProvider = Provider<DataSource>((ref) {
  return DataSourceImpl();
});

/// Provider for the application's Repository.
/// Receives the DataSource through dependency injection.
/// Follows the Clean Architecture pattern: DataSource → Repository → UI.
final repositoryProvider = Provider<Repository>((ref) {
  final dataSource = ref.watch(dataSourceProvider);
  return RepositoryImpl(dataSource);
});
