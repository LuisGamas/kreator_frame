// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';

part 'package_info_provider.g.dart';

@Riverpod(keepAlive: true)
Future<AsyncEnvironment> packageInfo(Ref ref) async {
  return await AsyncEnvironment.instance;
}
