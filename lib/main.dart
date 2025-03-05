import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/equipment_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        home: HomeScreen(),
        debugShowCheckedModeBanner: false, // Desativa o banner de debug
      ),
    );
  }
}
