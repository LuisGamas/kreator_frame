// 🎯 Dart imports:
import 'dart:typed_data';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';

/// Custom card widget optimized to display image previews
/// with additional information and enhanced visual effects.
/// 
/// Supports both images from URLs and from memory (Uint8List).
class CustomCardPreviews extends StatelessWidget {
  // === IMAGE PROPERTIES ===
  final Uint8List? image;
  final String? imageUrl;
  final bool isUrlImage;
  final bool addPadding;
  
  // === CONTENT PROPERTIES ===
  final String topText;
  final String bottomText;
  
  // === PRESENTATION PROPERTIES ===
  final double? heightPreview;
  final BoxFit? fitPreview;
  
  // === INTERACTION PROPERTIES ===
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
    return _CardContainer(
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
    );
  }
}

/// Main card container with enhanced visual effects
class _CardContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _CardContainer({
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.04),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: colors.primary.withValues(alpha: 0.08),
          highlightColor: colors.primary.withValues(alpha: 0.04),
          child: child,
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        height: heightPreview,
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        child: _buildImageWidget(),
      ),
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
      placeholder: (context, url) => const _LoadingPlaceholder(),
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: imageWidget,
          )
        : imageWidget;
  }
}

/// Loading placeholder with improved animation
class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    return Container(
      color: colors.surfaceContainerHigh,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 2.5,
              color: colors.primary,
            ),
            const SizedBox(height: 12),
            Text(
              // TODO: add localization
              'Cargando...',
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Error placeholder with improved design
class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    return Container(
      color: colors.errorContainer.withValues(alpha: 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              size: 32,
              color: colors.error.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 8),
            Text(
              // TODO: add localization
              'Error al cargar',
              style: TextStyle(
                color: colors.error.withValues(alpha: 0.8),
                fontSize: 11,
                fontWeight: FontWeight.w500,
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
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main text with typographical improvements
          Text(
            topText,
            style: textStyles.titleSmall?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          // Secondary text with subtle opacity
          Text(
            bottomText,
            style: textStyles.bodySmall?.copyWith(
              color: colors.onSurfaceVariant.withValues(alpha: 0.8),
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
