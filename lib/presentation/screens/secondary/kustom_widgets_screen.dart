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

/// Configuration for Kustom widget screen display.
///
/// Defines visual and behavioral settings for displaying KWGT or KLWP widgets.
/// Each configuration encapsulates the parameters needed to customize the grid
/// display, preview dimensions, and external linking behavior.
class KustomWidgetConfig {
  /// The file extension identifying the widget type (e.g., 'kwgt', 'klwp').
  final String widgetExtension;

  /// External URL/link to launch when tapping a widget card.
  final String externalLink;

  /// Height of each widget preview card in the grid.
  final double previewHeight;

  /// BoxFit setting for how preview images fit in their containers.
  final BoxFit previewFit;

  /// Whether to add padding around preview images.
  final bool addPadding;

  /// Display label for the tab bar.
  final String tabLabel;

  const KustomWidgetConfig({
    required this.widgetExtension,
    required this.externalLink,
    required this.previewHeight,
    required this.previewFit,
    required this.addPadding,
    required this.tabLabel,
  });

  /// Configuration for KWGT widgets.
  ///
  /// KWGT stands for Kustom Widget. These are smaller Android app widgets
  /// with standard dimensions and scaleDown fitting for proper aspect ratio
  /// preservation.
  static const kwgt = KustomWidgetConfig(
    widgetExtension: 'kwgt',
    externalLink: Environment.externalLinkKWGT,
    previewHeight: 200,
    previewFit: BoxFit.scaleDown,
    addPadding: true,
    tabLabel: 'KWGT',
  );

  /// Configuration for KLWP live wallpapers.
  ///
  /// KLWP stands for Kustom Live Wallpaper. These are fullscreen wallpapers
  /// with taller aspect ratios, using cover fitting for seamless display.
  static const klwp = KustomWidgetConfig(
    widgetExtension: 'klwp',
    externalLink: Environment.externalLinkKLWP,
    previewHeight: 290,
    previewFit: BoxFit.cover,
    addPadding: false,
    tabLabel: 'KLWP',
  );
}

/// A unified screen for displaying Kustom widgets (KWGT, KLWP, etc.).
///
/// This screen displays a masonry grid of Kustom widget previews fetched from
/// the repository. Each preview card shows the widget thumbnail, name, and
/// developer name. Tapping a card opens the corresponding Kustom app link
/// (typically Play Store) using the configured external link.
///
/// The screen is configured via [KustomWidgetConfig] which allows displaying
/// different widget types with customized preview heights, fitting behaviors,
/// and padding settings without code duplication.
///
/// Example:
/// ```dart
/// KustomWidgetsScreen(config: KustomWidgetConfig.kwgt)
/// ```
class KustomWidgetsScreen extends ConsumerWidget {
  final KustomWidgetConfig config;

  const KustomWidgetsScreen({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(repositoryProvider);
    final widgets = ref.watch(getWidgetsProvider(config.widgetExtension));

    return widgets.when(
      data: (data) {
        return MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: data.length,
          padding: const EdgeInsets.all(AppSpacing.xxs),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final widget = data[index];

            return ZoomIn(
              child: FadeIn(
                child: CustomCardPreviews(
                  isUrlImage: false,
                  image: widget.widgetThumbnail,
                  topText: widget.nameWidget,
                  bottomText: widget.nameDeveloper,
                  heightPreview: config.previewHeight,
                  fitPreview: config.previewFit,
                  addPadding: config.addPadding,
                  onTap: () => repository.launchExternalApp(config.externalLink),
                ),
              ),
            );
          },
        );
      },
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            AppLocalizations.of(context)!.errorMessage,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(strokeCap: StrokeCap.round),
      ),
    );
  }
}
