// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

// * Custom App Bar
class CustomSliverAppBar extends ConsumerWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final tabsBar = ref.watch(getTabsProvider);
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    // * Widget
    return SliverAppBar(
      backgroundColor: colors.surface,
      expandedHeight: size.height * 0.18,
      pinned: true,
      floating: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AppBarWidgets(textStyles: textStyles, colors: colors),
              ],
            ),
          ),
        ),
      ),
      bottom: tabsBar.when(
        data: (data) {
          return TabBar(
            labelStyle: textStyles.labelMedium,
            labelColor: colors.primary,
            indicatorColor: colors.primary,
            unselectedLabelColor: colors.outline,
            splashBorderRadius: BorderRadius.circular(10),
            tabs: data.map((tabEntity) => tabEntity.tabBar).toList(),
          );
        },
        error: (error, stackTrace) {
          return PreferredSize(
            preferredSize: Size.fromHeight( size.height * 0.2),
            child: const Center(
              child: Text('Error'),
            )
          );
        },
        loading: () {
          return PreferredSize(
            preferredSize: Size.fromHeight( size.height * 0.2),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          );
        },
      )
    ); 
  }
}

class _AppBarWidgets extends ConsumerWidget {
  const _AppBarWidgets({
    required this.textStyles,
    required this.colors,
  });

  final TextTheme textStyles;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final asyncEnvironment = ref.watch(getAsyncEnvironmentProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ZoomIn(
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/logo/app_logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ZoomIn(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              asyncEnvironment.when(
                data: (data) {
                  return Text(
                    data.packageName,
                    style: textStyles.headlineSmall!.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Text(
                    'Error here :(',
                    style: textStyles.headlineSmall!.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
                loading: () {
                  return Text(
                    '...',
                    style: textStyles.headlineSmall!.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              Environment.developerName == Environment.dashDeveloper
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.byDeveloper(Environment.developerName),
                    style: textStyles.bodySmall!.copyWith(
                      color: colors.onSurface,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Gap(2),
                  Icon(
                    Hicon.verifiedBold,
                    color: colors.primary,
                    size: 10,
                  ),
                ],
              )
              : Text(
                AppLocalizations.of(context)!.byDeveloper(Environment.developerName),
                style: textStyles.bodySmall!.copyWith(
                  color: colors.onSurface,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        ZoomIn(
          child: SizedBox(
            child: CustomFilledIconButton(
              onPressed: () => context.push('/settings'),
              buttonColor: colors.secondary,
              icon: Icon(
                Hicon.categoryBold,
                color: colors.onSecondary,
              ),
            ),
          ),
        )
      ],
    );
  }
}
