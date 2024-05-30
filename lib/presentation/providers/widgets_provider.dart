// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';

part 'widgets_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<WidgetEntity>> getWidgets(GetWidgetsRef ref, String widgetExt) async {
  final Repository repository = RepositoryImpl(DataSourceImpl());
  final widgetsList = await repository.getListOfWidgets(widgetExt, 'preset_thumb_portrait.jpg');
  return widgetsList;
}
