// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';
import 'package:kreator_frame/shared/utils/utils.dart';

/// A specialized download button for wallpapers with progress tracking.
///
/// This widget provides a complete download experience with:
/// - Loading state with spinning progress indicator
/// - Download progress with percentage display (0-100%)
/// - Permission handling (requests storage permission if needed)
/// - Error handling with snackbar feedback
/// - Success confirmation
///
/// The widget manages the download state internally and communicates with
/// the repository to handle the actual download operation using MediaStore
/// API for proper scoped storage support on Android 10+.
///
/// Example:
/// ```dart
/// WallpaperDownloadButton(
///   wallpaperEntity: wallpaper,
///   iconColor: Colors.white,
/// )
/// ```
class WallpaperDownloadButton extends ConsumerStatefulWidget {
  final WallpaperEntity wallpaperEntity;
  final Color? iconColor;

  const WallpaperDownloadButton({
    super.key,
    required this.wallpaperEntity,
    this.iconColor,
  });

  @override
  ConsumerState<WallpaperDownloadButton> createState() => _WallpaperDownloadButtonState();
}

class _WallpaperDownloadButtonState extends ConsumerState<WallpaperDownloadButton> {
  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
    final permissions = ref.watch(permissionsProvider);
    final progress = ref.watch(progressDownloaderProvider);
    final colors = Theme.of(context).colorScheme;

    // Show progress indicator if downloading and progress is available
    if (_isDownloading && progress != null && progress > 0) {
      return _buildProgressIndicator(progress);
    }

    return CustomIconButton(
      onPressed: () => permissions.storageGranted
        ? _downloadWallpaper(context, ref, colors)
        : ref.read(permissionsProvider.notifier).requestStoragePermission(),
      icon: Hicon.downloadOutline,
      iconColor: widget.iconColor ?? Colors.white,
      isLoading: _isDownloading,
    );
  }

  /// Builds a circular progress indicator with percentage text
  Widget _buildProgressIndicator(double progress) {
    final percentage = (progress * 100).toStringAsFixed(0);

    return Tooltip(
      message: '$percentage%',
      child: SizedBox(
        height: 48,
        width: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular progress indicator
            SizedBox(
              height: 28,
              width: 28,
              child: CircularProgressIndicator(
                value: progress,
                strokeCap: StrokeCap.round,
                strokeWidth: 2.5,
              ),
            ),
            // Percentage text
            Text(
              percentage,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Download the wallpaper using MediaStore API (Scoped Storage).
  ///
  /// This method does not require permissions on Android 10+ (API 29+) because it uses
  /// MediaStore to save the image directly to the device gallery.
  /// Only requires WRITE_EXTERNAL_STORAGE for Android 9 and earlier versions.
  Future<void> _downloadWallpaper(
    BuildContext context,
    WidgetRef ref,
    ColorScheme colors,
  ) async {
    setState(() => _isDownloading = true);

    try {
      final repository = ref.read(repositoryProvider);
      final progressNotifier = ref.read(progressDownloaderProvider.notifier);

      // Download and save the wallpaper using MediaStore with progress tracking
      final success = await repository.downloadWallpaper(
        widget.wallpaperEntity.url.trim(),
        widget.wallpaperEntity.name,
        onProgressUpdate: (progress) {
          // Update the progress in the Riverpod provider (0.0 to 1.0)
          progressNotifier.changeProgress(progress);
        },
      );

      if (context.mounted) {
        // Reset progress to 0
        progressNotifier.changeProgress(0);

        if (success) {
          SnackbarHelpers.showSuccess(
            context: context,
            message: AppLocalizations.of(context)!.downloadOk,
            color: colors,
          );
        } else {
          SnackbarHelpers.showError(
            context: context,
            message: AppLocalizations.of(context)!.downloadError,
            color: colors,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        SnackbarHelpers.showError(
          context: context,
          message: AppLocalizations.of(context)!.downloadError,
          color: colors,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }
}
