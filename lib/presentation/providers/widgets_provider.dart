// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';

/// Notifier that manages the widgets list by type.
/// Accepts a [widgetExt] parameter ('kwgt' or 'klwp') to filter specific widgets.
class WidgetsNotifier extends FamilyAsyncNotifier<List<WidgetEntity>, String> {
  @override
  Future<List<WidgetEntity>> build(String widgetExt) async {
    ref.keepAlive();
    final repository = ref.watch(repositoryProvider);
    return await repository.getListOfWidgets(widgetExt, 'preset_thumb_portrait.jpg');
  }
}

/// Provider that exposes the widgets list filtered by type.
/// Usage: `ref.watch(getWidgetsProvider('kwgt'))` or `ref.watch(getWidgetsProvider('klwp'))`
/// The state is kept in memory for the lifetime of the app.
final getWidgetsProvider = AsyncNotifierProvider.family<WidgetsNotifier, List<WidgetEntity>, String>(
  WidgetsNotifier.new,
);
