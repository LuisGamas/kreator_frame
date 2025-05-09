// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Environment {
  // * Declaration of static environment variables for non-instance access of the class
  static String developerName = dotenv.env['DEVELOPER_NAME'] ?? 'Error DEVELOPER_NAME';
  static String wallpapersUrl = dotenv.env['WALLPAPERS_URL'] ?? 'Error WALLPAPERS_URL';
  static String twitterUrl = dotenv.env['TWITTER'] ?? 'Error TWITTER';
  static String instagramUrl = dotenv.env['INSTAGRAM'] ?? 'Error INSTAGRAM';
  static String googlePlayStoreUrl = dotenv.env['GOOGLE_PLAY_STORE'] ?? 'Error GOOGLE_PLAY_STORE';

  // * Variables of SharedPreference **DO NOT REMOVE**
  static const String keyThemeMode = 'ThemeMode';
  static const String keyColorTheme = 'ColorTheme';

  // * Variables of Dashboard Preference **DO NOT REMOVE**
  static const String dashName = 'Kreator Frame';
  static const String dashVersion = '1.2.1 β';
  static const String dashDeveloper = 'Luis Gamas';

  static const String packageProfileImage = 'assets/logo/app_logo.png';
  static const String dashProfileImage = 'assets/logo/dashboard_logo.png';

  static const String externalLinkBuyMeACoffe = 'https://buymeacoffee.com/luisgamas';
  static const String externalLinkKLWP = 'https://play.google.com/store/apps/details?id=org.kustom.wallpaper';
  static const String externalLinkKWGT = 'https://play.google.com/store/apps/details?id=org.kustom.widget';
}

class AsyncEnvironment {
  late final String packageName;
  late final String packageVersion;
  bool _initialized = false;
  
  static final AsyncEnvironment _instance = AsyncEnvironment._internal();
  static Future<AsyncEnvironment> get instance async {
    await _instance._initialize();
    return _instance;
  }

  AsyncEnvironment._internal();

  Future<void> _initialize() async {
    if (!_initialized) {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        packageName = packageInfo.appName;
        packageVersion = packageInfo.version;
      } catch (e) {
        packageName = 'Error PACKAGE_NAME';
        packageVersion = 'Error PACKAGE_VERSION';
      }
      _initialized = true;
    }
  }
}
