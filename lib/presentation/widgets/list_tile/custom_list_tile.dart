// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';

/// A reusable list tile widget with consistent styling across the app.
///
/// Used in settings, licenses, and other list-based screens.
/// Supports optional leading widget, trailing icon, and fade-in animation.
class CustomListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onTap;
  final Widget? leadingWidget;
  final IconData? trailingIcon;
  final bool showAnimation;

  const CustomListTile({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTap,
    this.leadingWidget,
    this.trailingIcon,
    this.showAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    final tile = ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      splashColor: colors.secondaryContainer,
      textColor: colors.onSurface,
      title: Text(title),
      titleTextStyle: textStyles.titleMedium,
      subtitle: Text(subTitle),
      subtitleTextStyle: textStyles.bodySmall,
      leading: leadingWidget,
      trailing: Icon(
        trailingIcon ?? Hicon.right2Bold,
        color: colors.onSurface,
      ),
      onTap: onTap,
    );

    return showAnimation ? FadeIn(child: tile) : tile;
  }
}
