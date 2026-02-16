// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class ThemeSelectorScreen extends StatelessWidget {
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    // * Widget view
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // * App Bar
          CustomSliverAppBarScreens(
            tileText: AppLocalizations.of(context)!.themeAppBarTitle
          ),

          // * Title & Mode Theme Selector
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                AppLocalizations.of(context)!.themeSelector,
                style: textStyles.titleLarge
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.md),
            sliver: DecoratedSliver(
              decoration: BoxDecoration(
                borderRadius: AppRadius.radiusLg,
                color: colors.surfaceContainerHighest),
              sliver: const SliverPadding(
                padding: EdgeInsets.all(AppSpacing.md),
                sliver: ThemeModeSwitcher(),
              ),
            ),
          ),

          // * Separator
          const SliverGap(AppSpacing.lg),

          // * Title & Color Theme Selector
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                AppLocalizations.of(context)!.themeColorSelector,
                style: textStyles.titleLarge
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.md),
            sliver: DecoratedSliver(
              decoration: BoxDecoration(
                  borderRadius: AppRadius.radiusLg,
                  color: colors.surfaceContainerHighest),
              sliver: const SliverPadding(
                padding: EdgeInsets.all(AppSpacing.md),
                sliver: ColorThemeSwitcher(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
