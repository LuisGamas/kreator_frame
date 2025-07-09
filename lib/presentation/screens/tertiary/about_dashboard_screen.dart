// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
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
                          borderRadius: BorderRadius.circular(20),
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
                SizedBox(
                  height: 48,
                  child: CustomOutlineIconTextButton(
                    text: 'Twitter',
                    color: colors.primary,
                    icon: Icon(
                      Hicon.twitterBold,
                      size: 18,
                    ),
                    onPressed: () => repository.launchExternalApp('https://twitter.com/ErsteUomo'),
                  ),
                ),
                
                const Gap(8),
                // Social app 2
                SizedBox(
                  height: 48,
                  child: CustomOutlineIconTextButton(
                    text: 'Instagram',
                    color: colors.primary,
                    icon: Icon(
                      Hicon.instagramBold,
                      size: 18,
                    ),
                    onPressed: () => repository.launchExternalApp('https://www.instagram.com/ersteuomo/'),
                  ),
                ),
                
                const Gap(8),
                
                // Social app 3
                SizedBox(
                  height: 48,
                  child: CustomFilledIconTextButton(
                    text: 'Web Page',
                    buttonColor: colors.primary,
                    textColor: colors.onPrimary,
                    icon: Icon(
                      Hicon.websiteBold,
                      color: colors.onPrimary,
                      size: 18,
                    ),
                    onPressed: () => repository.launchExternalApp('https://kutt.it/gamas-dev'),
                  ),
                ),

                const Gap(35),

                // * Copyright
                Text(
                  'Copyright © Luis Gamas - Kreator Frame 2022',
                  style: textStyles.titleSmall,
                  textAlign: TextAlign.center,
                ),

                const Gap(16),
            
              ])
            ),
          ),

        ],

      )
    );
  }

}
