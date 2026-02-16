// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';

/// Provider del DataSource de la aplicación.
/// Responsable de instanciar la implementación del DataSource.
final dataSourceProvider = Provider<DataSource>((ref) {
  return DataSourceImpl();
});

/// Provider del Repository de la aplicación.
/// Recibe el DataSource a través de inyección de dependencias.
/// Sigue el patrón Clean Architecture: DataSource → Repository → UI.
final repositoryProvider = Provider<Repository>((ref) {
  final dataSource = ref.watch(dataSourceProvider);
  return RepositoryImpl(dataSource);
});
