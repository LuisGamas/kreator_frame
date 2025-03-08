// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class WallpaperPreviewScreen extends ConsumerWidget {
  final WallpaperEntity wallpaperEntity;

  const WallpaperPreviewScreen({super.key, required this.wallpaperEntity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          _buildHeroImage(size),
          _buildGradientOverlay(),
          _buildBottomContent(context, ref, size, textStyles, colors),
        ],
      ),
    );
  }

  Widget _buildHeroImage(Size size) {
    return Hero(
      tag: wallpaperEntity,
      child: Image(
        image: CachedNetworkImageProvider(wallpaperEntity.url),
        width: double.infinity,
        height: size.height,
        fit: BoxFit.fitHeight,
        loadingBuilder: (context, child, loadingProgress) {
          return loadingProgress == null
          ? child
          : const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
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

  Widget _buildGradientOverlay() {
    return const SizedBox.expand(
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
    );
  }

  Widget _buildBottomContent(BuildContext context, WidgetRef ref, Size size, TextTheme textStyles, ColorScheme colors) {
    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: FadeIn(
        delay: Durations.medium4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildWallpaperInfo(textStyles),
                  _buildActionButtons(context, ref, colors),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWallpaperInfo(TextTheme textStyles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          wallpaperEntity.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textStyles.headlineSmall?.copyWith(color: Colors.white),
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
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, ColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildIconButton(context, Hicon.heart2Outline, colors, AppLocalizations.of(context)!.noFunction),
        const Gap(5),
        _buildIconButton(context, Hicon.paletteOutline, colors, AppLocalizations.of(context)!.noFunction),
        const Gap(5),
        _buildDownloadButton(context, ref, colors),
        const Spacer(),
        _buildApplyWallpaperButton(context, ref, colors),
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, ColorScheme colors, String message) {
    return IconButton(
      onPressed: () => _showCustomSnackbar(
        context: context,
        message: message,
        backgroundColor: colors.secondaryContainer,
        colorText: colors.onSecondaryContainer,
      ),
      icon: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildDownloadButton(BuildContext context, WidgetRef ref, ColorScheme colors) {
    final progressDownloader = ref.watch(progressDownloaderProvider);
    final asyncEnvironment = ref.watch(getAsyncEnvironmentProvider);
    final permissions = ref.watch(permissionsProvider);

    return asyncEnvironment.when(
      data: (data) => progressDownloader != 0
          ? const CircularProgressIndicator(strokeWidth: 2)
          : IconButton(
              onPressed: () => permissions.storageGranted 
                ? _downloadWallpaper(context, ref, data.packageName, colors)
                : ref.read(permissionsProvider.notifier).requestPhotoLibrary(),
              icon: const Icon(Hicon.downloadOutline, color: Colors.white),
            ),
      error: (_, __) => const CircularProgressIndicator(strokeWidth: 2),
      loading: () => const CircularProgressIndicator(strokeWidth: 2),
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
        _showCustomSnackbar(
          context: context,
          message: AppLocalizations.of(context)!.downloadOk,
          backgroundColor: colors.secondaryContainer,
          colorText: colors.onSecondaryContainer,
        );
        ref.read(progressDownloaderProvider.notifier).changeProgress(0);
      },
      onDownloadError: (_) {
        _showCustomSnackbar(
          context: context,
          message: AppLocalizations.of(context)!.downloadError,
          backgroundColor: colors.errorContainer,
          colorText: colors.onErrorContainer,
        );
        ref.read(progressDownloaderProvider.notifier).changeProgress(0);
      },
    );
  }

  Widget _buildApplyWallpaperButton(BuildContext context, WidgetRef ref, ColorScheme colors) {
    final setWallpaperState = ref.watch(setWallpaperProvider);

    return GestureDetector(
      onTap: setWallpaperState ? null : () => _showBottomCard(context: context, ref: ref, colors: colors),
      child: ClipOval(
        child: Container(
          color: Colors.white,
          height: 60,
          width: 60,
          child: setWallpaperState
              ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Hicon.send1Outline, color: Colors.black),
        ),
      ),
    );
  }

  void _showCustomSnackbar({
    required BuildContext context,
    required String message,
    required Color? backgroundColor,
    required Color? colorText,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        showCloseIcon: true,
        closeIconColor: colorText,
        content: Text(
          message,
          style: TextStyle(color: colorText),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
      ));
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
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
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

  void _applyWallpaper(BuildContext context, WidgetRef ref) {
    final Repository repository = RepositoryImpl(DataSourceImpl());
    ref.read(setWallpaperProvider.notifier).changeState();
    context.pop();
    repository
        .setWallpaper(wallpaperEntity.url, screenLocation, MediaQuery.of(context).size)
        .whenComplete(() => ref.read(setWallpaperProvider.notifier).changeState());
  }
}
