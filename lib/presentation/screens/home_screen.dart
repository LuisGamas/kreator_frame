// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(inAppUpdateProvider.notifier).checkAppForUpdates();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabsBar = ref.watch(tabsBarAppProvider);
    final textStyles = Theme.of(context).textTheme;

    // * Listeners
    ref.listen(inAppUpdateProvider, (previous, next) async {
      if (next.canExecuteUpdate && !next.hasLaunchedUpdate) {
        await ref.read(inAppUpdateProvider.notifier).executeImmediateAppUpdate();
      }
    });

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
              strokeCap: StrokeCap.round
            )
          ),
        );

      },
    );

  }
}
