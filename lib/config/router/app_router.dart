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
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    // * Secondary Screens
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) {
        return pagesTransition(const SettingsScreen());
      },
    ),

    // * Tertiary Screens
    GoRoute(
      path: '/wallpaper-preview',
      builder: (context, state) {
        WallpaperEntity wallpaperEntity = state.extra as WallpaperEntity;
        return WallpaperPreviewScreen(wallpaperEntity: wallpaperEntity);
      },
    ),

    GoRoute(
      path: '/theme-selector',
      pageBuilder: (context, state) {
        return pagesTransition(const ThemeSelectorScreen());
      },
      //builder: (context, state) => const ThemeSelectorScreen(),
    ),

    GoRoute(
      path: '/kustom-app-information',
      pageBuilder: (context, state) {
        return pagesTransition(const AboutPackageAppScreen());
      },
      //builder: (context, state) => const AboutPackageAppScreen(),
    ),

    GoRoute(
      path: '/dashboard-information',
      pageBuilder: (context, state) {
        return pagesTransition(const AboutDashboardScreen());
      },
      //builder: (context, state) => const AboutDashboardScreen(),
    ),

    GoRoute(
      path: '/terms-and-conditions',
      pageBuilder: (context, state) {
        return pagesTransition(const TermsAndConditionsScreen());
      },
      //builder: (context, state) => const TermsAndConditionsScreen(),
    ),

    GoRoute(
      path: '/privacy-policy',
      pageBuilder: (context, state) {
        return pagesTransition(const PrivacyPolicyScreen());
      },
      //builder: (context, state) => const PrivacyPolicyScreen(),
    ),
  ]);
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
