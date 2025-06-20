import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:repeater/l10n/app_localizations.dart';
import 'package:repeater/services/notification_service.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/utils/theme_mode.dart';
import 'package:repeater/screens/main/init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await UserPreferences().init();
  await NotificationService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserPreferences()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserPreferences>(context).getUser();
    final colorScheme =
        Color(user == null ? Colors.teal.toARGB32() : user.colorScheme);

    return MaterialApp(
      locale: Locale(user?.locale ?? 'ms'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr, // Force Left-to-Right
          child: child!,
        );
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ms"),
        Locale("en"),
        Locale("ar"),
        Locale("ms", "Arab"),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Repeater',
      theme: Styles.lightTheme.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorScheme,
        ),
      ),
      darkTheme: Styles.darkTheme.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorScheme,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: (user == null)
          ? ThemeMode.system
          : mapStringtoThemeMode(user.themeMode),
      navigatorKey: navigatorKey,
      home: const Init(),
    );
  }
}
