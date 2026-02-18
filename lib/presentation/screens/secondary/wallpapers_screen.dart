// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class WallpapersScreen extends ConsumerWidget {
  const WallpapersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpapers = ref.watch( getWallpapersProvider );
    final appRouter = ref.watch(appRouterProvider);

    return wallpapers.when(
      data: (data) {
        // cellHeight = 290 (image) + 54 (text section) + 8 (Card margins) = 352dp
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 352,
          ),
          itemCount: data.length,
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
                    fitPreview: BoxFit.cover,
                    onTap: () => appRouter.push(AppRoutes.wallpaperPreview, extra: wallpaper),
                  ),
                ),
              ),
            );
          },
        );
      },
      error: (_, _) => ErrorView(
        onRetry: () => ref.invalidate(getWallpapersProvider),
      ),
      loading: () => const Center(child: CircularProgressIndicator( strokeCap: StrokeCap.round )),
    );
    
  }
}
