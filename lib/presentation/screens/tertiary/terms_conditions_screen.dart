// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // * Variables
    final Repository repository = RepositoryImpl(DataSourceImpl());
    final Locale locale = Localizations.localeOf(context);

    final futureFile = locale.languageCode == 'es'
        ? repository.getOfficialData('official', 'terms_conditions_es.md')
        : repository.getOfficialData('official', 'terms_conditions_en.md');

    // * Widget view
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          // * App Bar
          CustomSliverAppBarScreens(
              tileText: AppLocalizations.of(context)!.settingsLegalLT1),

          // * My Terms & Conditions from assets
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: FutureBuilder<String>(
                future: futureFile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.errorMessage
                      )
                    );
                  } else if (snapshot.hasData) {
                    return MarkdownBody(
                      styleSheet: MarkdownStyleSheet(
                        a: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      data: snapshot.data!,
                    );
                  } else {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.errorMessage
                      )
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
