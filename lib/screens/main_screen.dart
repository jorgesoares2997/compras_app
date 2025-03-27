import 'package:compras_app/generated/l10n.dart';
import 'package:compras_app/screens/add_equipment_screen.dart';
import 'package:compras_app/screens/calendar_screen.dart';
import 'package:compras_app/screens/home_screen.dart';
import 'package:compras_app/screens/report_screen.dart';
import 'package:compras_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Lista de telas correspondentes aos itens da navbar
  static final List<Widget> _screens = [
    HomeScreen(), // Ver Itens
    const CalendarScreen(), // Calendário
    const AddEquipmentScreen(), // Adicionar Itens
    const ReportScreen(), // Relatório
    const SettingsScreen(), // Configurações
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: const Icon(Icons.list), label: ''),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(icon: const Icon(Icons.bar_chart), label: ''),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: ''),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF02732A),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
