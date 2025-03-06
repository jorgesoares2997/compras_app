import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/equipment_provider.dart';
import 'screens/main_screen.dart'; // Novo import
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EquipmentProvider())],
      child: MaterialApp(
        title: 'Compras App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        ),
        home: const OnboardingScreen(), // Onboarding como tela inicial
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
