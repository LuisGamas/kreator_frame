// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';
import 'package:kreator_frame/shared/utils/utils.dart';

class WallpaperPreviewScreen extends ConsumerWidget {
  final WallpaperEntity wallpaperEntity;

  const WallpaperPreviewScreen({
    super.key,
    required this.wallpaperEntity
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
         _HeroImagePreview(wallpaperEntity: wallpaperEntity),
          
          const SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.70, 1.0],
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
          ),

          _BottomContentData(wallpaperEntity: wallpaperEntity),
        ],
      ),
    );
  }
}

// ##
class _HeroImagePreview extends StatelessWidget {
  final WallpaperEntity wallpaperEntity;

  const _HeroImagePreview({
    required this.wallpaperEntity,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Hero(
      tag: wallpaperEntity.url,
      child: Image(
        image: CachedNetworkImageProvider(wallpaperEntity.url),
        width: size.width,
        height: size.height,
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
        loadingBuilder: (context, child, loadingProgress) {
          return loadingProgress == null
          ? child
          : const Center(
            child: CircularProgressIndicator(strokeCap: StrokeCap.round),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Hicon.dangerTriangleOutline
            ),
          );
        },
      ),
    );
  }
}

// ##
class _BottomContentData extends StatelessWidget {
  final WallpaperEntity wallpaperEntity;

  const _BottomContentData({
    required this.wallpaperEntity,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    
    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: FadeIn(
        delay: Durations.medium4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Text(
              wallpaperEntity.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyles.headlineSmall?.copyWith(
                color: Colors.white
              ),
            ),
            Text(
              wallpaperEntity.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyles.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const _NoFunctionButton(icon: Hicon.heart2Outline),
                const Gap(5),
                const _NoFunctionButton(icon: Hicon.paletteOutline),
                const Gap(5),
                _DownloadButton(wallpaperEntity: wallpaperEntity),
                const Spacer(),
                _ApplyWallpaperButton(wallpaperEntity: wallpaperEntity),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

// ##
class _NoFunctionButton extends StatelessWidget {
  final IconData icon;

  const _NoFunctionButton({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: () => AppHelpers.showSnackbarError(
        context: context,
        message: AppLocalizations.of(context)!.noFunction,
        color: colors
      ),
      icon: Icon(icon, color: Colors.white),
    );
  }
}

// ##
class _DownloadButton extends ConsumerWidget {
  final WallpaperEntity wallpaperEntity;

  const _DownloadButton({
    required this.wallpaperEntity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressDownloader = ref.watch(progressDownloaderProvider);
    final packageAppInfo = ref.watch(packageInfoProvider);
    final permissions = ref.watch(permissionsProvider);
    final colors = Theme.of(context).colorScheme;

    return packageAppInfo.when(
      data: (data) => progressDownloader != 0
          ? _replaceButtonWithCircularProgress()
          : IconButton(
              onPressed: () => permissions.storageGranted 
                ? _downloadWallpaper(context, ref, data.appName, colors)
                : ref.read(permissionsProvider.notifier).requestPhotoLibrary(),
              icon: const Icon(Hicon.downloadOutline, color: Colors.white),
            ),
      error: (_, _) => _replaceButtonWithCircularProgress(),
      loading: () => _replaceButtonWithCircularProgress(),
    );
  }

  void _downloadWallpaper(BuildContext context, WidgetRef ref, String packageName, ColorScheme colors) {
    FileDownloader.downloadFile(
      url: wallpaperEntity.url.trim(),
      name: wallpaperEntity.name,
      subPath: packageName,
      onProgress: (_, progress) {
        ref.read(progressDownloaderProvider.notifier).changeProgress(progress);
      },
      onDownloadCompleted: (_) {
        AppHelpers.showSnackbarSuccess(
          context: context,
          message: AppLocalizations.of(context)!.downloadOk,
          color: colors
        );
        ref.read(progressDownloaderProvider.notifier).changeProgress(0);
      },
      onDownloadError: (_) {
        AppHelpers.showSnackbarError(
          context: context,
          message: AppLocalizations.of(context)!.downloadError,
          color: colors
        );
        ref.read(progressDownloaderProvider.notifier).changeProgress(0);
      },
    );
  }

  /// Replaces the download button with a [CircularProgressIndicator].
  ///
  /// This is used when the wallpaper is being downloaded or the package info
  /// is loading. The button is disabled while the progress indicator is shown.
  ///
  /// The progress indicator is 24 logical pixels in size and is styled with
  /// the current theme's color scheme.
  IconButton _replaceButtonWithCircularProgress() {
    return const IconButton(
      onPressed: null,
      icon: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round
        ),
      ),
    );
  }
}

// ##
class _ApplyWallpaperButton extends ConsumerWidget {
  final WallpaperEntity wallpaperEntity;

  const _ApplyWallpaperButton({
    required this.wallpaperEntity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setWallpaperState = ref.watch(setWallpaperProvider);
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: setWallpaperState
      ? null
      : () => _showBottomCard(
        context: context,
        ref: ref,
        colors: colors
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle
        ),
        height: 56,
        width: 56,
        child: setWallpaperState
          ? const Center(
            child: SizedBox(
              height: 28,
              width: 28,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round
              ),
            )
          )
          : const Icon(
            Hicon.send1Outline,
            color: Colors.black
          ),
      ),
    );
  }

  void _showBottomCard({
    required BuildContext context,
    required WidgetRef ref,
    required ColorScheme colors,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => _BottomCardContent(
        wallpaperEntity: wallpaperEntity,
        colors: colors,
      ),
    );
  }
}

// ##
class _BottomCardContent extends StatelessWidget {
  final WallpaperEntity wallpaperEntity;
  final ColorScheme colors;

  const _BottomCardContent({
    required this.wallpaperEntity,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.bottomWallSelectorTitle,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const Gap(5),
          Text(
            AppLocalizations.of(context)!.bottomWallSelectorSubTitle,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const Gap(15),
          _ModalButton(
            textButton: AppLocalizations.of(context)!.bottomWallSelectorHS,
            wallpaperEntity: wallpaperEntity,
            screenLocation: WallpaperManager.HOME_SCREEN,
          ),
          const Gap(5),
          _ModalButton(
            textButton: AppLocalizations.of(context)!.bottomWallSelectorLS,
            wallpaperEntity: wallpaperEntity,
            screenLocation: WallpaperManager.LOCK_SCREEN,
          ),
          const Gap(5),
          _ModalButton(
            textButton: AppLocalizations.of(context)!.bottomWallSelectorBS,
            wallpaperEntity: wallpaperEntity,
            screenLocation: WallpaperManager.BOTH_SCREEN,
          ),
          const Gap(16),
        ],
      ),
    );
  }
}

// ##
class _ModalButton extends ConsumerWidget {
  final WallpaperEntity wallpaperEntity;
  final String textButton;
  final int screenLocation;

  const _ModalButton({
    required this.wallpaperEntity,
    required this.textButton,
    required this.screenLocation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setWallpaperState = ref.watch(setWallpaperProvider);
    final colors = Theme.of(context).colorScheme;

    return setWallpaperState 
    ? Container(
      width: double.infinity,
      height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colors.primary
        ),
        child: const Center(
          child: SizedBox(
            height: 28,
            width: 28,
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round
            ),
          ),
        ),
      )
    : SizedBox(
      width: double.infinity,
      height: 55,
      child: CustomFilledButton(
        text: textButton,
        buttonColor: colors.primary,
        textColor: colors.onPrimary,
        onPressed: () => _applyWallpaper(context, ref),
      ),
    );
  }

  void _applyWallpaper(BuildContext context, WidgetRef ref) async {
    final repository = ref.watch(repositoryProvider);
    final appRouter = ref.watch(appRouterProvider);
    final colors = Theme.of(context).colorScheme;

    ref.read(setWallpaperProvider.notifier).changeState();

    final result = await repository.setWallpaper(wallpaperEntity.url, screenLocation, MediaQuery.sizeOf(context));

    if (context.mounted) {
      ref.read(setWallpaperProvider.notifier).changeState();
      if (result) {
        AppHelpers.showSnackbarSuccess(
          context: context,
          message: AppLocalizations.of(context)!.appliedOk,
          color: colors
        );
      } else {
        AppHelpers.showSnackbarError(
          context: context,
          message: AppLocalizations.of(context)!.appliedError,
          color: colors
        );
      }
      appRouter.pop();
    }
    
  }
}
