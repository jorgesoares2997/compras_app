import 'package:compras_app/providers/add_equipment_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Ver Itens
import 'calendar_screen.dart'; // Calendário (criaremos)

import 'report_screen.dart'; // Relatório (criaremos)
import 'settings_screen.dart'; // Configurações (criaremos)

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
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Ver Itens'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Adicionar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Relatório',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(
          0xFF02732A,
        ), // Cor do tema (verde escuro)
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type:
            BottomNavigationBarType
                .fixed, // Para 5 itens, evita animação de shift
      ),
    );
  }
}
