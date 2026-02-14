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
import 'package:kreator_frame/shared/utils/utils.dart';

class AboutPackageAppScreen extends ConsumerWidget {
  const AboutPackageAppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final packageAppInfo = ref.watch(packageInfoProvider);

    // * Widget view
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[

          // * App Bar
          CustomSliverAppBarScreens(
            tileText: AppLocalizations.of(context)!.settingsAboutLST1
          ),

          // * Data
          packageAppInfo.when(
            data: (data) => _SliverAboutPackage(
              packageName: data.appName,
            ),
            error: (error, stackTrace) => const _SliverAboutPackage(
              packageName: 'Error Package Name',
            ),
            loading: () => const _SliverAboutPackage(
              packageName: 'Loading...',
            ),
          )

        ],
      ),
    );
  }
}

class _SliverAboutPackage extends ConsumerWidget {
  final String packageName;

  const _SliverAboutPackage({
    required this.packageName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final repository = ref.watch(repositoryProvider);
    final colors = Theme.of(context).colorScheme;

    // * Data
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([

          // * Profile header
          ProfileHeader(
            imagePath: Environment.iconPackageLogo,
            title: packageName,
            subtitle: AppLocalizations.of(context)!.byDeveloper(Environment.userDeveloperName),
            showVerifiedBadge: Environment.userDeveloperName == Environment.dashDeveloper,
          ),

          const Gap(35),

          // * About Package App
          Text(
            AppLocalizations.of(context)!.aboutPackage(Environment.userDeveloperName, packageName),
          ),

          const Gap(35),

          // * Social media links
          SocialMediaButtonList(
            onTwitterPressed: () {
              Environment.userTwitterUrl != 'NA' && Environment.userTwitterUrl != 'Error TWITTER'
              ? repository.launchExternalApp(Environment.userTwitterUrl)
              : AppHelpers.showSnackbarError(
                context: context,
                message: AppLocalizations.of(context)!.errorMessage,
                color: colors
              );
            },
            onInstagramPressed: () {
              Environment.userInstagramUrl != 'NA' && Environment.userInstagramUrl != 'Error INSTAGRAM'
              ? repository.launchExternalApp(Environment.userInstagramUrl)
              : AppHelpers.showSnackbarError(
                context: context,
                message: AppLocalizations.of(context)!.errorMessage,
                color: colors
              );
            },
            onWebPagePressed: () {
              Environment.userPlayStoreUrl != 'NA' && Environment.userPlayStoreUrl != 'Error GOOGLE_PLAY_STORE'
              ? repository.launchExternalApp(Environment.userPlayStoreUrl)
              : AppHelpers.showSnackbarError(
                context: context,
                message: AppLocalizations.of(context)!.errorMessage,
                color: colors
              );
            },
          ),

          const Gap(16),

        ])
      ),
    );
  }
}
