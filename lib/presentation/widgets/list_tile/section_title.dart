// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';

/// A styled section title widget used as a header in list-based screens.
///
/// Displays a large title text with horizontal padding and an optional
/// fade-in animation. Used in settings and other screens to separate
/// groups of list tiles.
class SectionTitle extends StatelessWidget {
  final String title;
  final bool showAnimation;

  const SectionTitle({
    super.key,
    required this.title,
    this.showAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Text(
        title,
        style: textStyles.titleLarge!.copyWith(
          color: colors.onSurface,
        ),
      ),
    );

    return showAnimation ? FadeIn(child: content) : content;
  }
}
