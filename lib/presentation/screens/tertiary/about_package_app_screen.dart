// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
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
    final asyncEnvironment = ref.watch(packageInfoProvider);

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
          asyncEnvironment.when(
            data: (data) => _SliverAboutPackage(
              packageName: data.packageName,
              packageVersion: data.packageVersion,
            ),
            error: (error, stackTrace) => const _SliverAboutPackage(
              packageName: 'Error Package Name',
              packageVersion: 'Error Package Version',
            ),
            loading: () => const _SliverAboutPackage(
              packageName: 'Loading...',
              packageVersion: 'Loading...',
            ),
          )
          

        ],
      ),
    );
  }
}

class _SliverAboutPackage extends ConsumerWidget {
  final String packageName;
  final String packageVersion;

  const _SliverAboutPackage({
    required this.packageName,
    required this.packageVersion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final repository = ref.watch(repositoryProvider);
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    // * Data
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
      
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // * Dashboard profile Image
              ZoomIn(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage(Environment.iconPackageLogo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const Gap(15),

              // * Dashboard Data
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    Text(
                      packageName,
                      style: textStyles.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.byDeveloper(Environment.userDeveloperName),
                          style: textStyles.bodySmall!.copyWith(
                            color: colors.onSurface,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        if (Environment.userDeveloperName == Environment.dashDeveloper) ...[
                          const Gap(2),
                          Icon(
                            Hicon.verifiedBold,
                            color: colors.primary,
                            size: 10,
                          ),
                        ]
                      ],
                    )
                
                  ],
                ),
              ),

            ],
          ),

          const Gap(35),

          // * About Package App
          Text(
            AppLocalizations.of(context)!.aboutPackage(Environment.userDeveloperName, packageName),
          ),

          const Gap(35),

          // * Social Apps
          SizedBox(
            height: 48,
            child: CustomOutlineIconTextButton(
              text: 'Twitter',
              color: colors.primary,
              icon: Icon(
                Hicon.twitterBold,
                size: 18,
              ),
              onPressed: () {
                Environment.userTwitterUrl != 'NA' && Environment.userTwitterUrl != 'Error TWITTER'
                ? repository.launchExternalApp(Environment.userTwitterUrl)
                : AppHelpers.showSnackbarError(
                  context: context,
                  message: AppLocalizations.of(context)!.errorMessage,
                  color: colors
                );
              },
            ),
          ),
          
          const Gap(8),
          // Social app 2
          SizedBox(
            height: 48,
            child: CustomOutlineIconTextButton(
              text: 'Instagram',
              color: colors.primary,
              icon: Icon(
                Hicon.instagramBold,
                size: 18,
              ),
              onPressed: () {
                Environment.userInstagramUrl != 'NA' && Environment.userInstagramUrl != 'Error INSTAGRAM'
                ? repository.launchExternalApp(Environment.userInstagramUrl)
                : AppHelpers.showSnackbarError(
                  context: context,
                  message: AppLocalizations.of(context)!.errorMessage,
                  color: colors
                );
              },
            ),
          ),
          
          const Gap(8),
          
          // Social app 3
          SizedBox(
            height: 48,
            child: CustomFilledIconTextButton(
              text: 'Web Page',
              buttonColor: colors.primary,
              textColor: colors.onPrimary,
              icon: Icon(
                Hicon.websiteBold,
                size: 18,
              ),
              onPressed: () {
                Environment.userPlayStoreUrl != 'NA' && Environment.userPlayStoreUrl != 'Error GOOGLE_PLAY_STORE'
                ? repository.launchExternalApp(Environment.userPlayStoreUrl)
                : AppHelpers.showSnackbarError(
                  context: context,
                  message: AppLocalizations.of(context)!.errorMessage,
                  color: colors
                );
              },
            ),
          ),

          const Gap(16),
      
        ])
      ),
    );
  }
}
