// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/screens/screens.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(routes: [
    // * Primary Screens
    _createRoute('/', const HomeScreen()),

    // * Secondary Screens
    _createRoute('/settings', const SettingsScreen()),

    // * Tertiary Screens
    GoRoute(
      path: '/wallpaper-preview',
      builder: (context, state) {
        WallpaperEntity wallpaperEntity = state.extra as WallpaperEntity;
        return WallpaperPreviewScreen(wallpaperEntity: wallpaperEntity);
      },
    ),
    _createRoute('/theme-selector', const ThemeSelectorScreen()),
    _createRoute('/kustom-app-information', const AboutPackageAppScreen()),
    _createRoute('/dashboard-information', const AboutDashboardScreen()),
    _createRoute('/terms-and-conditions', const TermsAndConditionsScreen()),
    _createRoute('/privacy-policy', const PrivacyPolicyScreen()),

    // * Other Screens
    _createRoute('/licenses-screen', const LicensesScreen()),
    GoRoute(
      path: '/license-detail-screen',
      pageBuilder: (context, state) {
        LicenseEntity licenseEntity = state.extra as LicenseEntity;
        return pagesTransition(LicenseDetailScreen(licenseEntity: licenseEntity));
      },
    ),
  ]);
}

GoRoute _createRoute(String path, Widget page) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) {
      return pagesTransition(page);
    },
  );
}

CustomTransitionPage<dynamic> pagesTransition(Widget page) {
  return CustomTransitionPage(
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const beginOffset = Offset(1.0, 0.0);
      const endOffset = Offset.zero;
      var tween = Tween(begin: beginOffset, end: endOffset)
          .chain(CurveTween(curve: Curves.easeInOut));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
