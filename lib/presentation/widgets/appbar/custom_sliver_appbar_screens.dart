// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';

class CustomSliverAppBarScreens extends StatelessWidget {
  final String tileText;

  const CustomSliverAppBarScreens({super.key, required this.tileText});

  @override
  Widget build(BuildContext context) {
    // * Widget
    return SliverAppBar.large(
        pinned: true,
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Hicon.left1Bold)),
        title: Text(tileText));
  }
}
