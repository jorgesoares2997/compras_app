import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  Locale _currentLocale = const Locale('pt');

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  Locale get currentLocale => _currentLocale;

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[100],
    textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF2D4AE),
      foregroundColor: Colors.black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
    ),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A1A1A),
      foregroundColor: Colors.white,
    ),
  );

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (_currentLocale != locale) {
      _currentLocale = locale;
      notifyListeners();
    }
  }
}
