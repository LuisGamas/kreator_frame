// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class AboutDashboardScreen extends StatelessWidget {
  const AboutDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // * Variables
    final Repository repository = RepositoryImpl(DataSourceImpl());
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    // * Widget view
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[

          // * App Bar
          CustomSliverAppBarScreens(
            tileText: AppLocalizations.of(context)!.settingsAboutLST2
          ),

          // * Data
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // * Dashboard profile Image
                    ZoomIn(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage(Environment.dashProfileImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const Gap(15),

                    // * Dashboard Data
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                      
                              Text(
                                Environment.dashName,
                                style: textStyles.headlineSmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                      
                              const Gap(5),
                      
                              Icon(
                                Hicon.verifiedBold,
                                color: colors.primary,
                                size: 10,
                              ),
                      
                            ],
                          ),
                      
                          Text(
                            'Dashboard',
                            style: textStyles.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      
                        ],
                      ),
                    ),

                  ],
                ),

                const Gap(35),

                // * About Dashboard
                Text(
                  AppLocalizations.of(context)!.aboutDashboard,
                ),

                const Gap(35),

                // * Social Apps
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [

                    // Social app 1
                    SizedBox(
                      height: 45,
                      width: 120,
                      child: CustomFilledIconTextButton(
                        onPressed: () => repository.launchExternalApp('https://twitter.com/ErsteUomo'),
                        buttonColor: colors.secondary,
                        icon: Icon(
                          Hicon.twitterBold,
                          color: colors.onSecondary,
                          size: 17,
                        ),
                        label: Text(
                          'Twitter',
                          style: TextStyle(color: colors.onSecondary),
                        ),
                      ),
                    ),

                    const Gap(20),
                    // Social app 2
                    SizedBox(
                      height: 45,
                      width: 120,
                      child: CustomFilledIconTextButton(
                        onPressed: () => repository.launchExternalApp('https://www.instagram.com/ersteuomo/'),
                        buttonColor: colors.secondary,
                        icon: Icon(
                          Hicon.instagramBold,
                          color: colors.onSecondary,
                          size: 17,
                        ),
                        label: Text(
                          'Instagram',
                          style: TextStyle(color: colors.onSecondary),
                        ),
                      ),
                    ),

                    const Gap(20),

                    // Social app 3
                    SizedBox(
                      height: 45,
                      width: 120,
                      child: CustomFilledIconTextButton(
                        onPressed: () => repository.launchExternalApp('https://kutt.it/gamas-dev'),
                        buttonColor: colors.secondary,
                        icon: Icon(
                          Hicon.websiteBold,
                          color: colors.onSecondary,
                          size: 17,
                        ),
                        label: Text(
                          'Web Page',
                          style: TextStyle(color: colors.onSecondary),
                        ),
                      ),
                    ),

                  ],
                ),

                const Gap(35),

                // * Copyright
                Text(
                  'Copyright © Luis Gamas - Kreator Frame 2022',
                  style: textStyles.titleSmall,
                  textAlign: TextAlign.center,
                ),
            
              ])
            ),
          ),

        ],

      )
    );
  }

}
