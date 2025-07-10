// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';

part 'licenses_oss_provider.g.dart';

@Riverpod(keepAlive: true)
class LicensesOss extends _$LicensesOss {
  @override
   Future<List<LicenseEntity>> build() async {
    final repository = ref.watch(repositoryProvider);
    return await repository.getLicenses();
  }
}
