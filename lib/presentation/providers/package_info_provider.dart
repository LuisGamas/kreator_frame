// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info_provider.g.dart';

@Riverpod(keepAlive: true)
Future<AppInfoEntity> packageInfo(Ref ref) async {
  final repository = ref.watch(repositoryProvider);
  return await repository.getAppInformation();
}
