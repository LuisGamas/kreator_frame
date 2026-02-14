// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

/// A reusable column of social media buttons (Twitter, Instagram, Web Page).
///
/// Used in the about dashboard and about package screens to display
/// social media links with a consistent layout and styling.
class SocialMediaButtonList extends StatelessWidget {
  final VoidCallback? onTwitterPressed;
  final VoidCallback? onInstagramPressed;
  final VoidCallback? onWebPagePressed;

  const SocialMediaButtonList({
    super.key,
    this.onTwitterPressed,
    this.onInstagramPressed,
    this.onWebPagePressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Twitter
        SizedBox(
          height: 48,
          child: CustomOutlineIconTextButton(
            text: 'Twitter',
            color: colors.primary,
            icon: const Icon(Hicon.twitterBold, size: 18),
            onPressed: onTwitterPressed,
          ),
        ),

        const Gap(8),

        // Instagram
        SizedBox(
          height: 48,
          child: CustomOutlineIconTextButton(
            text: 'Instagram',
            color: colors.primary,
            icon: const Icon(Hicon.instagramBold, size: 18),
            onPressed: onInstagramPressed,
          ),
        ),

        const Gap(8),

        // Web Page
        SizedBox(
          height: 48,
          child: CustomFilledIconTextButton(
            text: 'Web Page',
            buttonColor: colors.primary,
            textColor: colors.onPrimary,
            icon: Icon(
              Hicon.websiteBold,
              color: colors.onPrimary,
              size: 18,
            ),
            onPressed: onWebPagePressed,
          ),
        ),
      ],
    );
  }
}
