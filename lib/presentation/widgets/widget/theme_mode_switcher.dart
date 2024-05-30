// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/shared/utils/utils.dart';

class ThemeModeSwitcher extends ConsumerWidget {
  const ThemeModeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSwitcher = ref.watch(appThemeModeProvider);
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: appThemesSelector.length,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final isSelectedThemeMode =
              appThemesSelector[index].themeMode == themeSwitcher;
          return GestureDetector(
            onTap: isSelectedThemeMode
                ? null
                : () => ref
                    .read(appThemeModeProvider.notifier)
                    .setSelectedThemeMode(appThemesSelector[index].themeMode),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(20),
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
                      appThemesSelector[index].icon,
                      size: 35,
                      color: colors.onSurface,
                    ),
                    const SizedBox(height: 2),
                    Text(appThemesSelector[index].title,
                        style: textStyles.titleSmall)
                  ],
                ),
              ),
            ),
          );
        },
        childCount: appThemesSelector.length,
      ),
    );
  }
}
