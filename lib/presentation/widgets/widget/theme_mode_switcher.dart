// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/shared/utils/utils.dart';

class ThemeModeSwitcher extends ConsumerWidget {
  const ThemeModeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appValuesFromPreference = ref.watch(appValuesPreferencesProvider);
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        crossAxisCount: AppHelpers.appThemesSelector.length,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          
          final isSelectedThemeMode = AppHelpers.appThemesSelector[index].themeMode 
                == appValuesFromPreference.themeModeForApp;
                
          return GestureDetector(
            onTap: isSelectedThemeMode
                ? null
                  : () => ref.read(appValuesPreferencesProvider.notifier)
                          .setPreferenceForThemeMode(AppHelpers.appThemesSelector[index].themeMode),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: isSelectedThemeMode ? colors.primary : colors.surface,
                  width: 3,
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      AppHelpers.appThemesSelector[index].icon,
                      size: 28,
                      color: colors.onSurface,
                    ),
                    const Gap(2),
                    Text(AppHelpers.appThemesSelector[index].title(context),
                        style: textStyles.titleSmall)
                  ],
                ),
              ),
            ),
          );
        },
        childCount: AppHelpers.appThemesSelector.length,
      ),
    );
  }
}
