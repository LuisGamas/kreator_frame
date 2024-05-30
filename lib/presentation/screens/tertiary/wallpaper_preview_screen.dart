// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
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
    // * Variables
    final Repository repository = RepositoryImpl(DataSourceImpl());
    final progressDownloader = ref.watch(progressDownloaderProvider);
    final setWallpaperState = ref.watch(setWallpaperProvider);
    final asyncEnvironment = ref.watch(getAsyncEnvironmentProvider);

    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    // * Widget view
    return Scaffold(
      body: Stack(
        children: [

          // * Image
          Hero(
            tag: wallpaperEntity,
            child: FancyShimmerImage(
              imageUrl: wallpaperEntity.url,
              height: size.height,
              width: size.width,
              boxFit: BoxFit.fitHeight,
            ),
          ),

          // * Black gradient below data and button
          const SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.70, 1.0],
                  colors: [Colors.transparent, Colors.black87]
                )
              )
            ),
          ),

          // * Widget container for data and buttons
          Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: FadeIn(
                delay: Durations.medium4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // * Image Data
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          // Wallpaper name
                          Text(
                            wallpaperEntity.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textStyles.headlineSmall!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          
                          // Wallpaper/Photo author
                          Text(
                            wallpaperEntity.author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyles.titleMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                          ),

                          // * Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              // Favorite button
                              IconButton(
                                onPressed: () {
                                  _showCustomSnackbar(
                                    context: context,
                                      message: AppLocalizations.of(context)!.noFunction,
                                      backgroundColor: colors.secondaryContainer,
                                      colorText: colors.onSecondaryContainer);
                                },
                                icon: const Icon(
                                  Hicon.heart2Outline,
                                  color: Colors.white,
                                ),
                              ),

                              // Separator
                              const Gap(5),

                              // Show wallpaper color pallete
                              IconButton(
                                onPressed: () {
                                  _showCustomSnackbar(
                                    context: context,
                                      message: AppLocalizations.of(context)!.noFunction,
                                      backgroundColor: colors.secondaryContainer,
                                      colorText: colors.onSecondaryContainer);
                                },
                                icon: const Icon(
                                  Hicon.paletteOutline,
                                  color: Colors.white,
                                ),
                              ),

                              // Separator
                              const Gap(5),

                              // Download button & Progress indicator
                              asyncEnvironment.when(
                                data: (data) {
                                  return progressDownloader != 0
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 2,
                                    )
                                  : IconButton(
                                      onPressed: progressDownloader != 0 
                                      ? null
                                      : () {
                                        FileDownloader.downloadFile(
                                          url:wallpaperEntity.url.trim(),
                                          name: wallpaperEntity.name,
                                          subPath: data.packageName,
                                          onProgress: (fileName, progress) {
                                            ref.read(progressDownloaderProvider.notifier).changeProgress(progress);
                                          },
                                          onDownloadCompleted: (path) {
                                            _showCustomSnackbar(
                                              context: context,
                                                message: AppLocalizations.of(context)!.downloadOk,
                                                backgroundColor: colors.secondaryContainer,
                                                colorText: colors.onSecondaryContainer);
                                            ref.read(progressDownloaderProvider.notifier).changeProgress(0);
                                          },
                                          onDownloadError: (errorMessage) {
                                            _showCustomSnackbar(
                                              context: context,
                                                message: AppLocalizations.of(context)!.downloadError,
                                                backgroundColor: colors.errorContainer,
                                                colorText: colors.onErrorContainer);
                                            ref.read(progressDownloaderProvider.notifier).changeProgress(0);
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Hicon.downloadOutline,
                                        color: Colors.white,
                                      ),
                                    );
                                },
                                error: (error, stackTrace) => const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                                loading: () => const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),

                              // Separator
                              const Spacer(),

                              // * Button to apply wallpaper
                              setWallpaperState == false
                              ? GestureDetector(
                                onTap: () {
                                  _showBottomCard(
                                    context: context,
                                    ref: ref,
                                    colors: colors,
                                    repository: repository,
                                    wallpaperEntity: wallpaperEntity
                                  );
                                },
                                child: ClipOval(
                                  child: Container(
                                    color: Colors.white,
                                    height: 60,
                                    width: 60,
                                    child: const Icon(
                                      Hicon.send1Outline,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                              : ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  height: 60,
                                  width: 60,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // * Callback for Snackbar
  void _showCustomSnackbar({
    required BuildContext context,
    required String message,
    required Color? backgroundColor,
    required Color? colorText
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      showCloseIcon: true,
      closeIconColor: colorText,
      content: Text(
        message,
        style: TextStyle(
          color: colorText,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
    ));
  }

  // * Callback for Bottom Modal Sheet
  void _showBottomCard({
    required BuildContext context,
    required WidgetRef ref,
    required ColorScheme colors,
    required Repository repository,
    required WallpaperEntity wallpaperEntity,
  }) {

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.36,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [

              // * Title
              Text(
                AppLocalizations.of(context)!.bottomWallSelectorTitle,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

              // Separator
              const Gap(5),

              // * Subtitle
              Text(
                AppLocalizations.of(context)!.bottomWallSelectorSubTitle,
                style: Theme.of(context).textTheme.bodySmall!,
                textAlign: TextAlign.center,
              ),

              // Separator
              const Gap(15),

              // * Button home screen
              _ModalButton(
                textButton: AppLocalizations.of(context)!.bottomWallSelectorHS,
                wallpaperEntity: wallpaperEntity,
                screenLocation: WallpaperManager.HOME_SCREEN,
              ),

              // Separator
              const Gap(5),

              // * Button lock screen
              _ModalButton(
                textButton: AppLocalizations.of(context)!.bottomWallSelectorLS,
                wallpaperEntity: wallpaperEntity,
                screenLocation: WallpaperManager.LOCK_SCREEN,
              ),

              // Separator
              const Gap(5),

              // * Button for both screen
              _ModalButton(
                textButton: AppLocalizations.of(context)!.bottomWallSelectorBS,
                wallpaperEntity: wallpaperEntity,
                screenLocation: WallpaperManager.BOTH_SCREEN,
              ),
              
            ],
          )
        );
      },
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
    // * Rivervop & variables
    final Repository repository = RepositoryImpl(DataSourceImpl());
    final colors = Theme.of(context).colorScheme;

    // * Widget Button
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: CustomFilledButton(
        text: textButton,
        buttonColor: colors.primary,
        textColor: colors.onPrimary,
        onPressed: () {
          ref.read(setWallpaperProvider.notifier).changeState();
          context.pop();
          var appliying = repository.setWallpaper(wallpaperEntity.url, screenLocation, MediaQuery.of(context).size);
          appliying.whenComplete(() => ref.read(setWallpaperProvider.notifier).changeState());
        },
      )
    );
  }
}
