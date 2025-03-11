// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';
import 'package:kreator_frame/presentation/screens/screens.dart';

part 'tabs_bar_app_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<TabBarEntity>>  getTabs(Ref ref) async {
  final Repository repository = RepositoryImpl(DataSourceImpl());
  final kwgt = await repository.getListOfWidgets('kwgt', 'preset_thumb_portrait.jpg');
  final klwp = await repository.getListOfWidgets('klwp', 'preset_thumb_portrait.jpg');
  List<TabBarEntity> tabList = [];

  if (kwgt.isNotEmpty) {
    tabList.add(
      TabBarEntity(
        tabBarView: const KWGTScreen(),
        tabBar: const Tab(text: 'KWGT'),
      )
    );
  }

  if (klwp.isNotEmpty) {
    tabList.add(
      TabBarEntity(
        tabBarView: const KLWPScreen(),
        tabBar: const Tab(text: 'KLWP'),
      )
    );
  }

  if (Environment.wallpapersUrl != 'NA' && Environment.wallpapersUrl != 'Error WALLPAPERS_URL') {
    tabList.add(
      TabBarEntity(
        tabBarView: const WallpapersScreen(),
        tabBar: const Tab(text: 'WALLPAPERS'),
      )
    );
  }

  return tabList;
}
