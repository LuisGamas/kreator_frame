// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

/// Notifier que gestiona la lista de widgets por tipo.
/// Acepta un parámetro [widgetExt] ('kwgt' o 'klwp') para filtrar widgets específicos.
class WidgetsNotifier extends FamilyAsyncNotifier<List<WidgetEntity>, String> {
  @override
  Future<List<WidgetEntity>> build(String widgetExt) async {
    ref.keepAlive();
    final repository = ref.watch(repositoryProvider);
    return await repository.getListOfWidgets(widgetExt, 'preset_thumb_portrait.jpg');
  }
}

/// Provider que expone la lista de widgets filtrada por tipo.
/// Uso: `ref.watch(getWidgetsProvider('kwgt'))` o `ref.watch(getWidgetsProvider('klwp'))`
/// El estado se mantiene en memoria durante la vida de la app.
final getWidgetsProvider = AsyncNotifierProvider.family<WidgetsNotifier, List<WidgetEntity>, String>(
  WidgetsNotifier.new,
);
