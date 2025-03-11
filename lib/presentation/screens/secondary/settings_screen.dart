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

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final asyncEnvironment = ref.watch(getAsyncEnvironmentProvider);

    // * Widget view
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          // * App Bar
          CustomSliverAppBarScreens(
            tileText: AppLocalizations.of(context)!.settingsAppBarTitle
          ),

          // * Data
          asyncEnvironment.when(
            data: (data) => _SettingsSliverList(
              packageName: data.packageName,
              packageVersion: data.packageVersion,
            ),
            error: (error, stackTrace) => const _SettingsSliverList(
              packageName: 'Error Package Name',
              packageVersion: 'Error Package Version',
            ),
            loading: () => const _SettingsSliverList(
              packageName: 'Loading...',
              packageVersion: 'Loading...',
            ),
          )

        ],
      ),
    );
  }

}

class _SettingsSliverList extends StatelessWidget {
  final String packageName;
  final String packageVersion;

  const _SettingsSliverList({
    required this.packageName,
    required this.packageVersion,
  });


  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([

        // * Banner for donations
        Dismissible(
          key: UniqueKey(),
          child: const _DonationChildDimissible(),
        ),
    
        // * First part
        _TitleListTile(
          title: AppLocalizations.of(context)!.settingsAppearance,
        ),
    
        _CustomListTile(
          title: AppLocalizations.of(context)!.settingsAppearanceLT1,
          subTitle: AppLocalizations.of(context)!.settingsAppearanceLST1,
          location: appearanceThemeRoute,
          leadingWidget: const Icon(Hicon.paletteBold),
        ),
    
        const Gap(25),
    
        // * Second part
        _TitleListTile(
          title: AppLocalizations.of(context)!.settingsAbout,
        ),
    
        _CustomListTile(
          title: packageName,
          subTitle: AppLocalizations.of(context)!.settingsAboutLST1,
          location: aboutPackageRoute,
          leadingWidget: const Icon(Hicon.stickerBold),
        ),
    
        _CustomListTile(
          title: Environment.dashName,
          subTitle: AppLocalizations.of(context)!.settingsAboutLST2,
          location: aboutDashboardRoute,
          leadingWidget: const Icon(Hicon.graphBold),
        ),
    
        const Gap(25),
    
        // * Third part
        _TitleListTile(
          title: AppLocalizations.of(context)!.settingsLegal,
        ),
    
        _CustomListTile(
          title: AppLocalizations.of(context)!.settingsLegalLT1,
          subTitle: AppLocalizations.of(context)!.settingsLegalLST1,
          location: legalTermsConditionsRoute,
          leadingWidget: const Icon(Hicon.documentAlignLeft4Bold),
        ),
    
        _CustomListTile(
          title: AppLocalizations.of(context)!.settingsLegalLT2,
          subTitle: AppLocalizations.of(context)!.settingsLegalLST2,
          location: legalPrivacyPolicyRoute,
          leadingWidget: const Icon(Hicon.documentAlignLeft4Bold),
        ),
    
        const Gap(25),
    
        // * Fourth part
        _TitleListTile(
          title: AppLocalizations.of(context)!.settingsLicences,
        ),

        _CustomListTile(
          title: AppLocalizations.of(context)!.settingsLicencesLT1,
          subTitle: AppLocalizations.of(context)!.settingsLicencesLST1,
          location: licensesOpenSourceRoute,
          leadingWidget: const Icon(Hicon.award2Bold),
        ),
    
        const Gap(25),
    
        // * Fifth part
        _TitleListTile(
          title: AppLocalizations.of(context)!.settingsVersions
        ),
    
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(packageName),
          subtitle: Text(packageVersion),
          leading: const Icon(Hicon.informationCircleBold),
        ),
    
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(Environment.dashName),
          subtitle: Text(Environment.dashVersion),
          leading: const Icon(Hicon.informationCircleBold),
        ),
    
      ])
    );
  }
}

// * Title Widget
class _TitleListTile extends StatelessWidget {
  final String title;

  const _TitleListTile({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Text(
          title,
          style: textStyles.titleLarge!.copyWith(
            color: colors.onSurface,
          )
        ),
      ),
    );
  }
}

// * Custom ListTile widget
class _CustomListTile extends ConsumerWidget {
  final String title;
  final String subTitle;
  final String? location;
  final Widget? leadingWidget;

  const _CustomListTile({
    required this.title,
    required this.subTitle,
    this.location,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final appRouter = ref.watch(appRouterProvider);

    return FadeIn(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        splashColor: colors.secondaryContainer,
        textColor: colors.onSurface,
        title: Text(title),
        titleTextStyle: textStyles.titleMedium,
        subtitle: Text(subTitle),
        subtitleTextStyle: textStyles.bodySmall,
        leading: leadingWidget,
        trailing: Icon(
          Hicon.right2Bold,
          color: colors.onSurface,
        ),
        onTap: location == null 
        ? null
        : () => appRouter.push(location!),
      ),
    );
  }
}

// * Dimissible Child Donation
class _DonationChildDimissible extends StatelessWidget {
  const _DonationChildDimissible();


  @override
  Widget build(BuildContext context) {
    final Repository repository = RepositoryImpl(DataSourceImpl());
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        color: colors.primaryContainer,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Icon(
              Hicon.heart2Bold,
              color: colors.onPrimaryContainer,
            ),

            const Gap(16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  Text(
                    AppLocalizations.of(context)!.donations,
                    style: textStyles.titleMedium!.copyWith(
                      color: colors.onPrimaryContainer,
                    ),
                  ),

                  Text(
                    AppLocalizations.of(context)!.donationsNote,
                    style: textStyles.bodySmall!.copyWith(
                      color: colors.onPrimaryContainer,
                    ),
                  ),

                  const Gap(10),

                  CustomOutlineButton(
                    color: colors.onPrimaryContainer,
                    text: AppLocalizations.of(context)!.donationsButton,
                    onPressed: () => repository.launchExternalApp('https://buymeacoffee.com/luisgamas'),
                  ),
              
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
