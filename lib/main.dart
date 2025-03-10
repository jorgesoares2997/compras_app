import 'dart:io';

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

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initNotifications(); // Inicializar notificações

  final authService = AuthService();
  final token = await authService.getToken();

  final prefs = await SharedPreferences.getInstance();
  final bool onboardingCompleted =
      prefs.getBool('onboarding_completed') ?? false;

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: flutterLocalNotificationsPlugin),
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

/// Inicializa as configurações para notificações locais
Future<void> _initNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  InitializationSettings settings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(settings);

  // Solicita permissões no iOS
  if (Platform.isIOS) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }
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
        return MaterialPageRoute(builder: (context) => const MainScreen());
      },
    );
  }
}

/// Exibe uma notificação local na barra do celular
Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'compras_app_channel', // ID único do canal
    'Notificações do Compras App',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );

  const NotificationDetails details = NotificationDetails(
    android: androidDetails,
    iOS: DarwinNotificationDetails(),
  );

  await flutterLocalNotificationsPlugin.show(
    0, // ID da notificação
    title,
    body,
    details,
  );
}
