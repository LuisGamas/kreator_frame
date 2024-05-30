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
    final colorSwitcher = ref.watch(appColorThemeProvider);
    final colors = Theme.of(context).colorScheme;

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final isSelectedColor =
              AppThemeColors.primaryColor[index] == colorSwitcher;
          return GestureDetector(
            onTap: isSelectedColor
                ? null
                : () => ref
                    .read(appColorThemeProvider.notifier)
                    .setColorTheme(AppThemeColors.primaryColor[index]),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppThemeColors.primaryColor[index],
                borderRadius: BorderRadius.circular(20),
              ),
              child: AnimatedOpacity(
                opacity: isSelectedColor ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: colors.onPrimary.withOpacity(0.7),
                      ),
                      child: const Icon(
                        Hicon.tickBold,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        childCount: AppThemeColors.primaryColor.length,
      ),
    );
  }
}
