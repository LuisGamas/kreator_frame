// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Variables
    final tabsBar = ref.watch(getTabsProvider);
    final textStyles = Theme.of(context).textTheme;

    return tabsBar.when(
      data: (data) {

        return Scaffold(
          body: DefaultTabController(
            length: data.length,
            child: Builder(builder: (context) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    // * App Bar
                    const CustomSliverAppBar(),        
                  ];
                },
                body: TabBarView(
                  children: data.map((tabEntity) => tabEntity.tabBarView).toList(),
                ),
              );
            }),
          ),
        );

      }, 
      error: (error, stackTrace) {

        return Scaffold(
          body: Center(
            child: Text(
              AppLocalizations.of(context)!.errorMessage,
              style: textStyles.titleLarge,
            ),
          ),
        );
        
      }, 
      loading: () {
        
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            )
          ),
        );

      },
    );

  }
}
