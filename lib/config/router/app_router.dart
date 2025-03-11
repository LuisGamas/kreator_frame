// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/screens/screens.dart';

part 'app_router.g.dart';

// * Routes Names
// Primary Routes
const homeRoute = '/';
// Secondary Routes
const settingsRoute = '/settings';
// Tertiary Routes
const wallpaperPreviewRoute = '/wallpaper-preview';
const appearanceThemeRoute = '/theme-selector';
const aboutPackageRoute = '/kustom-app-information';
const aboutDashboardRoute = '/dashboard-information';
const legalTermsConditionsRoute = '/terms-and-conditions';
const legalPrivacyPolicyRoute = '/privacy-policy';
// Licenses Routes
const licensesOpenSourceRoute = '/licenses-screen';
const licenseDetailRoute = '/license-detail-screen';

// * This is the router
@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(routes: [
    // Primary Screens
    _createRoute(homeRoute, const HomeScreen()),

    // Secondary Screens
    _createRoute(settingsRoute, const SettingsScreen()),

    // Tertiary Screens
    GoRoute(
      path: wallpaperPreviewRoute,
      builder: (context, state) {
        WallpaperEntity wallpaperEntity = state.extra as WallpaperEntity;
        return WallpaperPreviewScreen(wallpaperEntity: wallpaperEntity);
      },
    ),

    _createRoute(appearanceThemeRoute, const ThemeSelectorScreen()),
    _createRoute(aboutPackageRoute, const AboutPackageAppScreen()),
    _createRoute(aboutDashboardRoute, const AboutDashboardScreen()),
    _createRoute(legalTermsConditionsRoute, const TermsAndConditionsScreen()),
    _createRoute(legalPrivacyPolicyRoute, const PrivacyPolicyScreen()),

    // Other Screens
    _createRoute(licensesOpenSourceRoute, const LicensesScreen()),

    GoRoute(
      path: licenseDetailRoute,
      pageBuilder: (context, state) {
        LicenseEntity  licenseEntity = state.extra as LicenseEntity ;
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
