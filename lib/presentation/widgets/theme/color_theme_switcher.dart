// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/shared/utils/utils.dart';

class ColorThemeSwitcher extends ConsumerWidget {
  const ColorThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appValuesFromPreference = ref.watch(appValuesPreferencesProvider);
    final colors = Theme.of(context).colorScheme;

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: AppSpacing.xxs,
        mainAxisSpacing: AppSpacing.xxs,
        crossAxisCount: 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {

          final isSelectedColor = AppHelpers.primaryColor[index] 
            == appValuesFromPreference.colorAccentForTheme;

          return GestureDetector(
            onTap: isSelectedColor
                ? null
                  : () => ref.read(appValuesPreferencesProvider.notifier)
                      .setPreferenceForColorAccent(AppHelpers.primaryColor[index]),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppHelpers.primaryColor[index],
                borderRadius: AppRadius.radiusLg,
              ),
              child: AnimatedOpacity(
                opacity: isSelectedColor ? 1 : 0,
                duration: AppDurations.normal,
                child: Center(
                  child: ClipRRect(
                    borderRadius: AppRadius.radiusSm,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.radiusXs,
                        color: colors.onPrimary.withValues(alpha: 0.7),
                      ),
                      child: const Icon(
                        Hicon.tickBold,
                        size: AppIconSizes.xxs,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        childCount: AppHelpers.primaryColor.length,
      ),
    );
  }
}
