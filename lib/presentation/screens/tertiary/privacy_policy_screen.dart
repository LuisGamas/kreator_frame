// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // * Variables
    final Repository repository = RepositoryImpl(DataSourceImpl());
    final Locale locale = Localizations.localeOf(context);

    // * Widget view
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          // * App Bar
          CustomSliverAppBarScreens(
              tileText: AppLocalizations.of(context)!.settingsLegalLT2),

          // * My Privacy Policy from assets
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                child: locale.languageCode == 'en'
                    ? repository.getOfficialData('official' ,'privacy_policy_en.md')
                    : repository.getOfficialData('official' ,'privacy_policy_es.md'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
