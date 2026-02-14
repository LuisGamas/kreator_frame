// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';

/// A reusable profile header widget that displays an image, title,
/// subtitle, and an optional verified badge.
///
/// Used in the about dashboard and about package screens to show
/// profile information with a consistent layout.
class ProfileHeader extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool showVerifiedBadge;

  const ProfileHeader({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.showVerifiedBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile image
        ZoomIn(
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const Gap(15),

        // Title and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: textStyles.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (showVerifiedBadge) ...[
                    const Gap(5),
                    Icon(
                      Hicon.verifiedBold,
                      color: colors.primary,
                      size: 10,
                    ),
                  ],
                ],
              ),
              Text(
                subtitle,
                style: textStyles.titleSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
