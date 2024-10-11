// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class AboutPackageAppScreen extends ConsumerWidget {
  const AboutPackageAppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final asyncEnvironment = ref.watch(getAsyncEnvironmentProvider);

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

class _SliverAboutPackage extends StatelessWidget {

  final String packageName;
  final String packageVersion;

  const _SliverAboutPackage({
    required this.packageName,
    required this.packageVersion,
  });

  @override
  Widget build(BuildContext context) {
    // * Variables
    final Repository repository = RepositoryImpl(DataSourceImpl());
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
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/logo/app_logo.png'),
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
                
                    Environment.developerName == Environment.dashDeveloper
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.byDeveloper(Environment.developerName),
                          style: textStyles.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const Gap(5),

                        Icon(
                          Hicon.verifiedBold,
                          color: colors.primary,
                          size: 10,
                        ),

                      ],

                    )
                    : Text(
                      AppLocalizations.of(context)!.byDeveloper(Environment.developerName),
                      style: textStyles.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                
                  ],
                ),
              ),

            ],
          ),

          const Gap(35),

          // * About Package App
          Text(
            AppLocalizations.of(context)!.aboutPackage(Environment.developerName, packageName),
          ),

          const Gap(35),

          // * Social Apps

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Social app 1
              SizedBox(
                height: 45,
                width: 45,
                child: CustomFilledIconButton(
                  onPressed: () {

                    Environment.twitterUrl != 'NA' && Environment.twitterUrl != 'Error TWITTER'
                    ? repository.launchExternalApp(Environment.twitterUrl)
                    : _showCustomSnackbar(context);
                  },
                  buttonColor: colors.secondary,
                  icon: Icon(
                    Hicon.twitterBold,
                    color: colors.onSecondary,
                    size: 17,
                  ),
                ),
              ),

              const Gap(20),
              // Social app 2
              SizedBox(
                height: 45,
                width: 45,
                child: CustomFilledIconButton(
                  onPressed: () {

                    Environment.instagramUrl != 'NA' && Environment.instagramUrl != 'Error INSTAGRAM'
                    ? repository.launchExternalApp(Environment.instagramUrl)
                    : _showCustomSnackbar(context);
                  },
                  buttonColor: colors.secondary,
                  icon: Icon(
                    Hicon.instagramBold,
                    color: colors.onSecondary,
                    size: 17,
                  ),
                ),
              ),

              const Gap(20),

              // Social app 3
              SizedBox(
                height: 45,
                width: 45,
                child: CustomFilledIconButton(
                  onPressed: () {

                    Environment.googlePlayStoreUrl != 'NA' && Environment.googlePlayStoreUrl != 'Error GOOGLE_PLAY_STORE'
                    ? repository.launchExternalApp(Environment.googlePlayStoreUrl)
                    : _showCustomSnackbar(context);
                  },
                  buttonColor: colors.secondary,
                  icon: Icon(
                    Hicon.bag1Bold,
                    color: colors.onSecondary,
                    size: 17,
                  ),
                ),
              ),

            ],
          ),
      
        ])
      ),
    );
  }

  // * Callback for Snackbar
  void _showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.primary,
      showCloseIcon: true,
      closeIconColor: Theme.of(context).colorScheme.onPrimary,
      content: Text(
        AppLocalizations.of(context)!.errorMessage,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
    ));
  }

}
