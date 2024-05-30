// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress_downloader_provider.g.dart';

@riverpod
class ProgressDownloader extends _$ProgressDownloader {
  @override
  double? build() {
    return 0;
  }

  void changeProgress(double? progress) {
    state = progress;
  }
}
