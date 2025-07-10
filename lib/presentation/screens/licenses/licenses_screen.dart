// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class LicensesScreen extends ConsumerWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final licensesOss = ref.watch(licensesOssProvider);
    final appRouter = ref.watch(appRouterProvider);

    return Scaffold(
      body: licensesOss.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
          )
        ),
        data: (licenses) => CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App Bar
              CustomSliverAppBarScreens(
                tileText: AppLocalizations.of(context)!.settingsLicencesLT1,
              ),

              // Body Data
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
          ),
        error: (_, __) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            AppLocalizations.of(context)!.errorMessage,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ),
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
