// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// Centralized design tokens for the application.
/// Provides visual consistency across the entire UI.

// ===========================================================================
// SPACING
// ===========================================================================

/// Standard spacing tokens for paddings, margins, and gaps.
class AppSpacing {
  AppSpacing._();

  static const double xxxs = 2.0;
  static const double xxs = 4.0;
  static const double xs = 6.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

// ===========================================================================
// BORDER RADIUS
// ===========================================================================

/// Standard border radius tokens for containers, buttons, and cards.
class AppRadius {
  AppRadius._();

  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 28.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double full = 9999.0;

  static final BorderRadius radiusXs = BorderRadius.circular(xs);
  static final BorderRadius radiusSm = BorderRadius.circular(sm);
  static final BorderRadius radiusMd = BorderRadius.circular(md);
  static final BorderRadius radiusLg = BorderRadius.circular(lg);
  static final BorderRadius radiusXl = BorderRadius.circular(xl);
  static final BorderRadius radiusXxl = BorderRadius.circular(xxl);
  static final BorderRadius radiusFull = BorderRadius.circular(full);
}

// ===========================================================================
// SHADOWS
// ===========================================================================

/// Standard shadow tokens for elevating elements.
class AppShadows {
  AppShadows._();

  static List<BoxShadow> get sm => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get md => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get lg => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get xl => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
}

// ===========================================================================
// ANIMATION DURATIONS
// ===========================================================================

/// Standard duration tokens for animations and transitions.
class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration slower = Duration(milliseconds: 600);
}

// ===========================================================================
// ICON SIZES
// ===========================================================================

/// Standard size tokens for icons and small avatars.
class AppIconSizes {
  AppIconSizes._();

  static const double xxxs = 12.0;
  static const double xxs = 16.0;
  static const double xs = 18.0;
  static const double sm = 20.0;
  static const double md = 24.0;
  static const double lg = 28.0;
  static const double xl = 40.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}
