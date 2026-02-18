// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/router/app_routes.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/screens/screens.dart';

/// Provider for the main application router.
/// Configures all routes and navigation transitions.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      // Primary Screens
      _createRoute(AppRoutes.home, const HomeScreen()),

      // Secondary Screens
      _createRoute(AppRoutes.settings, const SettingsScreen()),

      // Tertiary Screens
      GoRoute(
        path: AppRoutes.wallpaperPreview,
        builder: (context, state) {
          WallpaperEntity wallpaperEntity = state.extra as WallpaperEntity;
          return WallpaperPreviewScreen(wallpaperEntity: wallpaperEntity);
        },
      ),

      _createRoute(AppRoutes.appearanceTheme, const ThemeSelectorScreen()),
      _createRoute(AppRoutes.aboutPackage, const AboutPackageAppScreen()),
      _createRoute(AppRoutes.aboutDashboard, const AboutDashboardScreen()),

      // Other Screens
      _createRoute(AppRoutes.licensesOpenSource, const LicensesScreen()),

      GoRoute(
        path: AppRoutes.licenseDetail,
        pageBuilder: (context, state) {
          LicenseEntity licenseEntity = state.extra as LicenseEntity;
          return pagesTransition(LicenseDetailScreen(licenseEntity: licenseEntity));
        },
      ),
    ],
  );
});

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
