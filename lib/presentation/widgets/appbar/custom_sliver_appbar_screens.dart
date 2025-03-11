// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';

class CustomSliverAppBarScreens extends ConsumerWidget {
  final String tileText;

  const CustomSliverAppBarScreens({super.key, required this.tileText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    // * Widget
    return SliverAppBar.large(
        pinned: true,
        leading: IconButton(
            onPressed: () => appRouter.pop(),
            icon: const Icon(Hicon.left1Bold)),
        title: Text(tileText));
  }
}
