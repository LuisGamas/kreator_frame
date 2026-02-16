// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
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
        crossAxisSpacing: AppSpacing.xs,
        mainAxisSpacing: AppSpacing.xs,
        crossAxisCount: AppConstants.themeModeOptions.length,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          
          final isSelectedThemeMode = AppConstants.themeModeOptions[index].themeMode 
                == appValuesFromPreference.themeModeForApp;
                
          return GestureDetector(
            onTap: isSelectedThemeMode
                ? null
                  : () => ref.read(appValuesPreferencesProvider.notifier)
                          .setPreferenceForThemeMode(AppConstants.themeModeOptions[index].themeMode),
            child: AnimatedContainer(
              duration: AppDurations.normal,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: AppRadius.radiusXl,
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
                      AppConstants.themeModeOptions[index].icon,
                      size: AppIconSizes.md,
                      color: colors.onSurface,
                    ),
                    const Gap(AppSpacing.xxxs),
                    Text(AppConstants.themeModeOptions[index].title(context),
                        style: textStyles.titleSmall)
                  ],
                ),
              ),
            ),
          );
        },
        childCount: AppConstants.themeModeOptions.length,
      ),
    );
  }
}
