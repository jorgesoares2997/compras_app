import 'package:compras_app/generated/l10n.dart';
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
  String? _selectedLanguage = 'Português';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizations = AppLocalizations.of(context)!; // Acessa as traduções

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
        backgroundColor: const Color(0xFFF2D4AE),
      ),
      body: Stack(
        children: [
          const ParticleBackground(backgroundColor: Color(0xFFFFE6E6)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(localizations.darkMode),
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
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(localizations.language),
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
                            Locale newLocale;
                            switch (value) {
                              case 'English':
                                newLocale = const Locale('en');
                                break;
                              case 'Español':
                                newLocale = const Locale('es');
                                break;
                              case 'Português':
                              default:
                                newLocale = const Locale('pt');
                            }
                            themeProvider.setLocale(newLocale);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Idioma alterado para $value'),
                              ),
                            );
                          });
                        },
                        underline: Container(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(localizations.profile),
                      subtitle: Text(localizations.editProfile),
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
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.notifications),
                      title: Text(localizations.notifications),
                      subtitle: Text(localizations.configureAlerts),
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
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.info),
                      title: Text(localizations.about),
                      subtitle: Text(localizations.version),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Audio IBP',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '© 2025 Jorge Soares',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        localizations.logout,
                        style: const TextStyle(color: Colors.red),
                      ),
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
