// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';

/// Entry point of the Kreator Frame application.
///
/// Initializes Flutter bindings, sets portrait orientation, loads environment
/// variables from .env file, and starts the app with Riverpod state management.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

/// Root widget of the Kreator Frame application.
///
/// Configures the MaterialApp with:
/// - Localization support (English and Spanish)
/// - Go Router navigation
/// - Dynamic theming (light/dark modes with custom accent colors)
/// - Material You dynamic color support
/// - State management via Riverpod providers
class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final appValuesFromPreference = ref.watch(appValuesPreferencesProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final ThemeData lightTheme;
        final ThemeData darkTheme;

        if (appValuesFromPreference.isDynamicColor && lightDynamic != null) {
          lightTheme = AppTheme.buildFromColorScheme(lightDynamic);
          darkTheme = AppTheme.buildFromColorScheme(darkDynamic!);
        } else {
          final appTheme = AppTheme(primaryColor: appValuesFromPreference.colorAccentForTheme);
          lightTheme = appTheme.lightTheme;
          darkTheme = appTheme.darkTheme;
        }

        return MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: appRouter,
          themeMode: appValuesFromPreference.themeModeForApp,
          theme: lightTheme,
          darkTheme: darkTheme,
        );
      },
    );
  }
}
