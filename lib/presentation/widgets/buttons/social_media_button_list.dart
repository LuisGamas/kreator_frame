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
  final VoidCallback? onPersonalSitePressed;

  const SocialMediaButtonList({
    super.key,
    this.onTwitterPressed,
    this.onInstagramPressed,
    this.onPersonalSitePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Twitter
        CustomIconButton.tonal(
          buttonSize: 56,
          iconSize: AppIconSizes.md,
          tooltip: 'Twitter',
          icon: Hicon.twitterBold,
          onPressed: onTwitterPressed,
        ),

        const Gap(AppSpacing.sm),

        // Instagram
        CustomIconButton.tonal(
          buttonSize: 56,
          iconSize: AppIconSizes.md,
          tooltip: 'Instagram',
          icon: Hicon.instagramBold,
          onPressed: onInstagramPressed,
        ),

        const Gap(AppSpacing.sm),

        // Web Page
        CustomIconButton.tonal(
          buttonSize: 56,
          iconSize: AppIconSizes.md,
          tooltip: 'Personal Site',
          icon: Hicon.websiteBold,
          onPressed: onPersonalSitePressed,
        ),
      ],
    );
  }
}
