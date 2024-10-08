import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LicensesScreen extends StatelessWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Repository repository = RepositoryImpl(DataSourceImpl());

    // * Widget view
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // * App Bar
          CustomSliverAppBarScreens(
            tileText: AppLocalizations.of(context)!.settingsLicencesLT1
          ),
          // * Data
          FutureBuilder<List<LicenseEntity>>(
            future: repository.getLicenses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator( strokeWidth: 2 )),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(AppLocalizations.of(context)!.errorMessage)),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(AppLocalizations.of(context)!.errorMessage)),
                );
              }

              final licenses = snapshot.data!;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final license = licenses[index];
                    return FadeIn(
                      child: _CustomListTile(
                        title: license.name,
                        subTitle: license.description,
                        onTap: () => context.push('/license-detail-screen', extra: license),
                      ),
                    );
                  },
                  childCount: licenses.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// * Custom ListTile widget
class _CustomListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? onTap;

  const _CustomListTile({
    required this.title,
    required this.subTitle,
    required this.onTap
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
      trailing: Icon(
        Hicon.right2Bold,
        color: colors.onSurface,
      ),
      onTap: onTap,
    );
  }
}