// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';

part 'widgets_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<WidgetEntity>> getWidgets(Ref ref, String widgetExt) async {
  final repository = ref.watch(repositoryProvider);
  final widgetsList = await repository.getListOfWidgets(widgetExt, 'preset_thumb_portrait.jpg');
  return widgetsList;
}
