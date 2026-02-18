/// Application routes configuration.
/// Centralized route path constants for the entire application.
/// All navigation references should use these constants to ensure consistency.
abstract class AppRoutes {
  AppRoutes._();

  // Primary Routes
  /// Home screen route.
  static const String home = '/';

  // Secondary Routes
  /// Settings screen route.
  static const String settings = '/settings';

  // Tertiary Routes
  /// Wallpaper preview screen route.
  /// Expects: WallpaperEntity as extra parameter.
  static const String wallpaperPreview = '/wallpaper-preview';

  /// Theme selector screen route.
  static const String appearanceTheme = '/theme-selector';

  /// About package/app information screen route.
  static const String aboutPackage = '/kustom-app-information';

  /// About dashboard information screen route.
  static const String aboutDashboard = '/dashboard-information';

  // Licenses Routes
  /// Open source licenses screen route.
  static const String licensesOpenSource = '/licenses-screen';

  /// License detail screen route.
  /// Expects: LicenseEntity as extra parameter.
  static const String licenseDetail = '/license-detail-screen';
}
