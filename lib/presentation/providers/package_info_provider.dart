// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';

part 'package_info_provider.g.dart';

@Riverpod(keepAlive: true)
Future<AsyncEnvironment> getAsyncEnvironment(GetAsyncEnvironmentRef ref) async {
  return await AsyncEnvironment.instance;
}
