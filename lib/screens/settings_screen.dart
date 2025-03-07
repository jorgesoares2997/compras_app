import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/screens/login_screen.dart';
import 'package:compras_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _selectedLanguage = 'Português'; // Valor padrão

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: const Color(0xFFF2D4AE),
      ),
      body: Stack(
        children: [
          // Fundo de partículas com vermelho clarinho
          const ParticleBackground(
            backgroundColor: Color(0xFFFFE6E6), // Vermelho bem clarinho
          ),
          // Título "AudioIBP" no topo

          // Conteúdo da tela
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 16),
            child: SingleChildScrollView(
              // Adicionado para evitar overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  // Alternar tema claro/escuro
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: const Text('Modo Escuro'),
                      trailing: Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.toggleTheme();
                        },
                        activeColor: const Color(0xFF02732A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Seleção de idioma
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Idioma'),
                      trailing: DropdownButton<String>(
                        value: _selectedLanguage,
                        items: const [
                          DropdownMenuItem(
                            value: 'Português',
                            child: Text('Português'),
                          ),
                          DropdownMenuItem(
                            value: 'English',
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: 'Español',
                            child: Text('Español'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedLanguage = value;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Idioma alterado para $value'),
                              ),
                            );
                          });
                        },
                        underline: Container(), // Remove a linha padrão
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Perfil
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Perfil'),
                      subtitle: const Text('Editar nome e foto'),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Perfil em desenvolvimento'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Notificações
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text('Notificações'),
                      subtitle: const Text('Configurar alertas'),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Notificações em desenvolvimento'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Sobre
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Sobre'),
                      subtitle: const Text('Versão 1.0.0'),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Compras App',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '© 2025 Jorge Soares',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Logout
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        'Sair',
                        style: TextStyle(color: Colors.red),
                      ),
                      // No ListTile de "Sair"
                      onTap: () async {
                        await AuthService().logout();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
