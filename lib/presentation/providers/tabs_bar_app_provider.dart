// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/providers/repository_provider.dart';
import 'package:kreator_frame/presentation/screens/screens.dart';

/// Notifier que gestiona la lista de pestañas de la aplicación.
/// Crea dinámicamente las pestañas basadas en los widgets y wallpapers disponibles.
class TabsBarAppNotifier extends AsyncNotifier<List<TabBarEntity>> {
  @override
  Future<List<TabBarEntity>> build() async {
    ref.keepAlive();
    final repository = ref.watch(repositoryProvider);
    final kwgt = await repository.getListOfWidgets('kwgt', 'preset_thumb_portrait.jpg');
    final klwp = await repository.getListOfWidgets('klwp', 'preset_thumb_portrait.jpg');
    List<TabBarEntity> tabList = [];

    if (kwgt.isNotEmpty) {
      tabList.add(
        TabBarEntity(
          tabBarView: const KustomWidgetsScreen(config: KustomWidgetConfig.kwgt),
          tabBar: Tab(text: KustomWidgetConfig.kwgt.tabLabel),
        ),
      );
    }

    if (klwp.isNotEmpty) {
      tabList.add(
        TabBarEntity(
          tabBarView: const KustomWidgetsScreen(config: KustomWidgetConfig.klwp),
          tabBar: Tab(text: KustomWidgetConfig.klwp.tabLabel),
        ),
      );
    }

    if (Environment.userWallpapersUrl != 'NA' &&
        Environment.userWallpapersUrl != 'Error WALLPAPERS_URL') {
      tabList.add(
        TabBarEntity(
          tabBarView: const WallpapersScreen(),
          tabBar: const Tab(text: 'WALLPAPERS'),
        ),
      );
    }

    return tabList;
  }
}

/// Provider que expone la lista de pestañas de la aplicación.
/// El estado se mantiene en memoria durante la vida de la app.
final tabsBarAppProvider = AsyncNotifierProvider<TabsBarAppNotifier, List<TabBarEntity>>(
  TabsBarAppNotifier.new,
);
