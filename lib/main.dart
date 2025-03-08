import 'package:compras_app/generated/l10n.dart';
import 'package:compras_app/localization.dart';
import 'package:compras_app/providers/equipment_provider.dart';
import 'package:compras_app/providers/theme_provider.dart';
import 'package:compras_app/screens/add_equipment_screen.dart';
import 'package:compras_app/screens/calendar_screen.dart';
import 'package:compras_app/screens/home_screen.dart';
import 'package:compras_app/screens/login_screen.dart';
import 'package:compras_app/screens/main_screen.dart';
import 'package:compras_app/screens/onboarding_screen.dart';
import 'package:compras_app/screens/register_screen.dart';
import 'package:compras_app/screens/report_screen.dart';
import 'package:compras_app/screens/settings_screen.dart';
import 'package:compras_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar notificações
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  final authService = AuthService();
  final token = await authService.getToken();

  final prefs = await SharedPreferences.getInstance();
  final bool onboardingCompleted =
      prefs.getBool('onboarding_completed') ?? false;

  runApp(
    MultiProvider(
      providers: [
        Provider.value(
          value: flutterLocalNotificationsPlugin,
        ), // Adiciona o plugin ao Provider
        ChangeNotifierProvider(create: (context) => EquipmentProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(
        initialRoute:
            onboardingCompleted
                ? (token != null ? '/main' : '/login')
                : '/onboarding',
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizationsDelegate.supportedLocales,
      locale: themeProvider.currentLocale,
      debugShowCheckedModeBanner: false,
      title: 'Compras App',
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: initialRoute,
      routes: {
        '/home': (context) => HomeScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/report': (context) => const ReportScreen(),
        '/add_equipment': (context) => const AddEquipmentScreen(),
      },
      onUnknownRoute: (settings) {
        // Redirecionar para /main se a rota for desconhecida
        return MaterialPageRoute(builder: (context) => const MainScreen());
      },
    );
  }
}
