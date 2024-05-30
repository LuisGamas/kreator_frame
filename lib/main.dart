// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/presentation/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final primaryColorTheme = ref.watch(appColorThemeProvider);

    Color getPrimaryColor() {
      ref.read(appColorThemeProvider.notifier).updateColorTheme();
      return primaryColorTheme;
    }

    ThemeMode getTheme() {
      ref.read(appThemeModeProvider.notifier).updateThemeFromStorage();
      return themeMode;
    }

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
      themeMode: getTheme(),
      theme: AppTheme(primaryColor: getPrimaryColor()).getLightTheme(),
      darkTheme: AppTheme(primaryColor: getPrimaryColor()).getDarkTheme(),
    );
  }
}
