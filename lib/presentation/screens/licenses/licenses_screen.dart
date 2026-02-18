// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
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
                    return CustomListTile(
                      title: license.name,
                      subTitle: '${license.licenseCount} License${license.licenseCount == 1 ? '' : 's'}',
                      onTap: () => appRouter.push(
                        AppRoutes.licenseDetail,
                        extra: license,
                      ),
                    );
                  },
                  childCount: licenses.length,
                ),
              ),
            ],
          ),
        error: (_, _) => ErrorView(
          onRetry: () => ref.invalidate(licensesOssProvider),
        )
      ),
    );

  }
}

