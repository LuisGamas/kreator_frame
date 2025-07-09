// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class LicensesScreen extends ConsumerWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Repository repository = RepositoryImpl(DataSourceImpl());
    final appRouter = ref.watch(appRouterProvider);

    return Scaffold(
      body: FutureBuilder<List<LicenseEntity>>(
        future: repository.getLicenses(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          } else if (snapshot.hasError) {
            return Center(child: Text(AppLocalizations.of(context)!.errorMessage));
          }

          final licenses = snapshot.data ?? [];

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // * App Bar
              CustomSliverAppBarScreens(
                tileText: AppLocalizations.of(context)!.settingsLicencesLT1,
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final license = licenses[index];
                    return FadeIn(
                      child: _CustomListTile(
                        title: license.name,
                        subTitle: '${license.licenseCount} License${license.licenseCount == 1 ? '' : 's'}',
                        onTap: () => appRouter.push(
                          licenseDetailRoute,
                          extra: license,
                        ),
                      ),
                    );
                  },
                  childCount: licenses.length,
                ),
              ),
            ],
          );
        },
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
    required this.onTap,
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
