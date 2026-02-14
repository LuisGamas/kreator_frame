// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class AboutDashboardScreen extends ConsumerWidget {
  const AboutDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final repository = ref.watch(repositoryProvider);
    final textStyles = Theme.of(context).textTheme;

    // * Widget view
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[

          // * App Bar
          CustomSliverAppBarScreens(
            tileText: AppLocalizations.of(context)!.settingsAboutLST2
          ),

          // * Data
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // * Profile header
                const ProfileHeader(
                  imagePath: Environment.iconDashboardLogo,
                  title: Environment.dashName,
                  subtitle: 'Dashboard',
                  showVerifiedBadge: true,
                ),

                const Gap(35),

                // * About Dashboard
                Text(
                  AppLocalizations.of(context)!.aboutDashboard,
                ),

                const Gap(35),

                // * Social media links
                SocialMediaButtonList(
                  onTwitterPressed: () => repository.launchExternalApp(Environment.externalLinkTwitter),
                  onInstagramPressed: () => repository.launchExternalApp(Environment.externalLinkInstagram),
                  onWebPagePressed: () => repository.launchExternalApp(Environment.externalLinkWebsite),
                ),

                const Gap(35),

                // * Copyright
                Text(
                  'Copyright © Luis Gamas - Kreator Frame 2022',
                  style: textStyles.titleSmall,
                  textAlign: TextAlign.center,
                ),

                const Gap(16),

              ])
            ),
          ),

        ],

      )
    );
  }
}
