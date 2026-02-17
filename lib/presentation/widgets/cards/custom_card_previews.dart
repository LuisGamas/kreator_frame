// 🎯 Dart imports:
import 'dart:typed_data';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';

/// Custom card widget optimized to display image previews
/// with additional information and enhanced visual effects.
/// 
/// Supports both images from URLs and from memory (Uint8List).
class CustomCardPreviews extends StatelessWidget {
  final Uint8List? image;
  final String? imageUrl;
  final bool isUrlImage;
  final bool addPadding;
  final String topText;
  final String bottomText;
  final double? heightPreview;
  final BoxFit? fitPreview;
  final VoidCallback? onTap;

  const CustomCardPreviews({
    super.key,
    this.image,
    required this.topText,
    required this.bottomText,
    this.imageUrl,
    required this.isUrlImage,
    this.addPadding = false,
    this.heightPreview,
    required this.fitPreview,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      color: colors.surfaceContainerHighest,
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ImagePreviewSection(
              image: image,
              imageUrl: imageUrl,
              isUrlImage: isUrlImage,
              addPadding: addPadding,
              heightPreview: heightPreview,
              fitPreview: fitPreview,
            ),
            _TextContentSection(
              topText: topText,
              bottomText: bottomText,
            ),
          ],
        ),
      ),
    );
  }
}

/// Optimized image preview section
class _ImagePreviewSection extends StatelessWidget {
  final Uint8List? image;
  final String? imageUrl;
  final bool isUrlImage;
  final bool addPadding;
  final double? heightPreview;
  final BoxFit? fitPreview;

  const _ImagePreviewSection({
    this.image,
    this.imageUrl,
    required this.isUrlImage,
    required this.addPadding,
    this.heightPreview,
    required this.fitPreview,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: heightPreview,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        color: colors.surfaceContainer,
      ),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    if (isUrlImage) {
      return _NetworkImageWidget(
        imageUrl: imageUrl,
        fitPreview: fitPreview,
      );
    } else {
      return _MemoryImageWidget(
        image: image,
        addPadding: addPadding,
        fitPreview: fitPreview,
      );
    }
  }
}

/// Specialized widget for network images
class _NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fitPreview;

  const _NetworkImageWidget({
    this.imageUrl,
    required this.fitPreview,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl?.isEmpty ?? true) {
      return const _ErrorPlaceholder();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: fitPreview,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
        ),
      ),
      errorWidget: (context, url, error) => const _ErrorPlaceholder(),
    );
  }
}

/// Specialized widget for images in memory
class _MemoryImageWidget extends StatelessWidget {
  final Uint8List? image;
  final bool addPadding;
  final BoxFit? fitPreview;

  const _MemoryImageWidget({
    this.image,
    required this.addPadding,
    required this.fitPreview,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const _ErrorPlaceholder();
    }

    final imageWidget = Image.memory(
      image!,
      fit: fitPreview,
      errorBuilder: (context, error, stackTrace) => const _ErrorPlaceholder(),
    );

    return addPadding
      ? Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: imageWidget,
        )
      : imageWidget;
  }
}

/// Error placeholder with improved design
class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    
    return Container(
      color: colors.errorContainer.withValues(alpha: 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Hicon.linkBold,
              size: AppIconSizes.lg,
              color: colors.onErrorContainer,
            ),
           const Gap(AppSpacing.sm),
            Text(
              'Error',
              style: textStyles.labelMedium?.copyWith(
                color: colors.onErrorContainer
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Optimized text content section
class _TextContentSection extends StatelessWidget {
  final String topText;
  final String bottomText;

  const _TextContentSection({
    required this.topText,
    required this.bottomText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main text with typographical improvements
          Text(
            topText,
            style: textStyles.titleSmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(AppSpacing.xxxs),
          // Secondary text with subtle opacity
          Text(
            bottomText,
            style: textStyles.bodySmall?.copyWith(
              color: colors.onSurfaceVariant.withValues(alpha: 0.8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
