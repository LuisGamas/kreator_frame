// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// Entity representing a tab bar configuration.
/// Contains both the tab header and the associated content view.
class TabBarEntity {
  final Widget tabBarView;
  final Tab tabBar;

  TabBarEntity({
    required this.tabBarView,
    required this.tabBar,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabBarEntity && other.tabBar == tabBar;

  @override
  int get hashCode => tabBar.hashCode;
}
