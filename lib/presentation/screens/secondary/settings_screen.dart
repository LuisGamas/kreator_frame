// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
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
    // * Variables
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return SliverList(
      delegate: SliverChildListDelegate([
    
        // * First part
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.settingsAppearance,
            style: textStyles.titleLarge!.copyWith(
              color: colors.onSurface,
            )
          ),
        ),
    
        _CustomListTile(
          title: AppLocalizations.of(context)!.settingsAppearanceLT1,
          subTitle: AppLocalizations.of(context)!.settingsAppearanceLST1,
          location: '/theme-selector',
          leadingWidget: const Icon(Hicon.paletteBold),
        ),
    
        const Gap(25),
    
        // * Second part
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.settingsAbout,
            style: textStyles.titleLarge!.copyWith(
              color: colors.onSurface,
            )
          ),
        ),
    
        _CustomListTile(
          title: packageName,
          subTitle: AppLocalizations.of(context)!.settingsAboutLST1,
          location: '/kustom-app-information',
          leadingWidget: const Icon(Hicon.stickerBold),
        ),
    
        _CustomListTile(
          title: Environment.dashName,
          subTitle: AppLocalizations.of(context)!.settingsAboutLST2,
          location: '/dashboard-information',
          leadingWidget: const Icon(Hicon.graphBold),
        ),
    
        const Gap(25),
    
        // * Third part
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.settingsLegal,
            style: textStyles.titleLarge!.copyWith(
              color: colors.onSurface,
            )
          ),
        ),
    
        _CustomListTile(
          title: AppLocalizations.of(context)!.settingsLegalLT1,
          subTitle: AppLocalizations.of(context)!.settingsLegalLST1,
          location: '/terms-and-conditions',
          leadingWidget: const Icon(Hicon.documentAlignLeft4Bold),
        ),
    
        _CustomListTile(
          title: AppLocalizations.of(context)!.settingsLegalLT2,
          subTitle: AppLocalizations.of(context)!.settingsLegalLST2,
          location: '/privacy-policy',
          leadingWidget: const Icon(Hicon.documentAlignLeft4Bold),
        ),
    
        const Gap(25),
    
        // * Fourth part
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.settingsLicences,
            style: textStyles.titleLarge!.copyWith(
              color: colors.onSurface,
            )
          ),
        ),
    
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(AppLocalizations.of(context)!.settingsLicencesLT1),
          subtitle: Text(AppLocalizations.of(context)!.settingsLicencesLST1),
          leading: const Icon(Hicon.award2Bold),
          trailing: const Icon(Hicon.right2Bold),
          onTap: () => showLicensePage(
            context: context,
            applicationName: Environment.dashName,
            applicationLegalese: 'Dashboard',
            applicationIcon: const Icon(
              Hicon.graphBold,
              size: 40,
            ),
            applicationVersion: Environment.dashVersion,
          ),
        ),
    
        const Gap(25),
    
        // * Fifth part
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.settingsVersions,
            style: textStyles.titleLarge!.copyWith(
              color: colors.onSurface,
            )
          ),
        ),
    
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(packageName), // AQUI
          subtitle: Text(packageVersion), // AQUI
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

// * Custom ListTile widget
class _CustomListTile extends StatelessWidget {
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
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return ListTile(
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
      : () => context.push(location!),
    );
  }
}
