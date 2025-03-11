// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class ThemeSelectorScreen extends StatelessWidget {
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // * Variables
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    // * Widget view
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          
          // * App Bar
          CustomSliverAppBarScreens(
            tileText: AppLocalizations.of(context)!.themeAppBarTitle
          ),

          // * Title & Mode Theme Selector
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppLocalizations.of(context)!.themeSelector,
                style: textStyles.titleLarge
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: DecoratedSliver(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: colors.surfaceContainerHighest),
              sliver: const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                sliver: ThemeModeSwitcher(),
              ),
            ),
          ),

          // * Separator
          const SliverGap(20),

          // * Title & Color Theme Selector
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppLocalizations.of(context)!.themeColorSelector,
                style: textStyles.titleLarge
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: DecoratedSliver(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: colors.surfaceContainerHighest),
              sliver: const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                sliver: ColorThemeSwitcher(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
