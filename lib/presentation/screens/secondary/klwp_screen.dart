// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class KLWPScreen extends ConsumerWidget {
  
  const KLWPScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final Repository repository = RepositoryImpl(DataSourceImpl());
    final widgets = ref.watch( getWidgetsProvider('klwp') );

    // * Widget to show KLWP widgets
    return widgets.when(
      data: (data) {
        return MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: data.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  heightPreview: 290,
                  fitPreview: BoxFit.cover,
                  onTap: () => repository.launchExternalApp('https://play.google.com/store/apps/details?id=org.kustom.wallpaper'),
                ),
              ),
            );

          },
        );
      },
      error: (error, stackTrace) => Center(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(AppLocalizations.of(context)!.errorMessage,
          textAlign: TextAlign.center,
        ),
      )),
      loading: () => const Center(child: CircularProgressIndicator( strokeWidth: 2 )),
    );

  }
}
