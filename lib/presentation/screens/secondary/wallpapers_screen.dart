// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class WallpapersScreen extends ConsumerWidget {
  const WallpapersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpapers = ref.watch( getWallpapersProvider );
    final appRouter = ref.watch(appRouterProvider);

    // * Widget to show Wallpapers Web previews
    return wallpapers.when(
      data: (data) {
        return MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: data.length,
          addAutomaticKeepAlives: true,
          padding: const EdgeInsets.all(AppSpacing.xxs),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {

            final wallpaper = data[index];

            return ZoomIn(
              child: FadeIn(
                child: Hero(
                  tag: wallpaper.url,
                  child: CustomCardPreviews(
                    isUrlImage: true,
                    imageUrl: wallpaper.url,
                    topText: wallpaper.name,
                    bottomText: wallpaper.author,
                    heightPreview: 290,
                    fitPreview: BoxFit.cover,
                    onTap: () => appRouter.push(AppRoutes.wallpaperPreview, extra: wallpaper),
                  ),
                ),
              ),
            );

          },
        );
      },
      error: (error, stackTrace) => Center(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Text(AppLocalizations.of(context)!.errorMessage,
          textAlign: TextAlign.center,
        ),
      )),
      loading: () => const Center(child: CircularProgressIndicator( strokeCap: StrokeCap.round )),
    );
    
  }
}
