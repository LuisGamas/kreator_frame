// 🎯 Dart imports:
import 'dart:typed_data';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';

class CustomCardPreviews extends StatelessWidget {

  final Uint8List? image;
  final String topText;
  final String bottomText;
  final String? imageUrl;
  final bool isUrlImage;
  final bool? addPadding;
  final double? heightPreview;
  final BoxFit? fitPreview;
  final void Function()? onTap;

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
    final textStyles = Theme.of(context).textTheme;

    return Card.filled(
      color: const Color(0xFF0F1011),
      elevation: 2,
      child: GestureDetector(
        onTap: onTap,
        child: Column(

          children: [
            // * The preview of the widgets
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              ),
              child: SizedBox(
                width: double.infinity,
                height: heightPreview,
                child: isUrlImage != false
                ? _loadImagePreview(CachedNetworkImageProvider(imageUrl!))
                : addPadding == false
                ? _loadImagePreview(MemoryImage(image!))
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: _loadImagePreview(MemoryImage(image!))
                ),
              ),
            ),
        
            // * The preview of the data (Name of widget and Name of developer)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight:  Radius.circular(10)
                )
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top text
                  Text(
                    topText,
                    style: textStyles.titleSmall!.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Bottom text
                  Text(
                    bottomText,
                    style: textStyles.bodySmall!.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
        
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

  Image _loadImagePreview (ImageProvider<Object> image) {
    return Image(
      image: image,
      fit: fitPreview,
      loadingBuilder: (context, child, loadingProgress) {
        return loadingProgress == null
        ? child
        : const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(
            Hicon.dangerTriangleOutline
          ),
        );
      },
    );
  }
}
