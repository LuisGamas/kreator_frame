// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class CustomSliverAppBarScreens extends ConsumerWidget {
  final String tileText;

  const CustomSliverAppBarScreens({super.key, required this.tileText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final colors = Theme.of(context).colorScheme;

    // * Widget
    return SliverAppBar.large(
        pinned: true,
        leading: CustomIconButton(
            onPressed: () => appRouter.pop(),
            icon: Hicon.left1Bold,
            iconColor: colors.onSurface,
          ),
        title: Text(tileText));
  }
}
