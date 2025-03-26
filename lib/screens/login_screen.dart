import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/generated/l10n.dart';
import 'package:compras_app/screens/register_screen.dart';
import 'package:compras_app/services/auth_service.dart';
import 'package:compras_app/services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Configuração do Google Sign-In
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '911266742263-jm27q7p4v862mdic2p7ntacmpocutat8.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  Future<void> testarRelatorios(BuildContext context) async {
    final reportService = ReportService();
    try {
      final response = await reportService.listarTodosRelatorios();
      print(
        "Resposta da API de relatórios: ${response.statusCode} - ${response.data}",
      );
    } catch (e) {
      print("Erro ao acessar relatórios: $e");
    }
  }

  Future<void> _login(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final authService = Provider.of<AuthService>(context, listen: false);
        final token = await authService.login(
          _emailController.text,
          _passwordController.text,
        );
        setState(() => _isLoading = false);

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('email', _emailController.text);
          await prefs.setString('password', _passwordController.text);
          print("Token salvo após login: $token");
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(localizations.loginFailed)));
        }
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${localizations.loginFailed}: $e')),
        );
      }
    }
  }

  // Função para login com Google
  Future<void> _loginWithGoogle(BuildContext context) async {
    setState(() => _isLoading = true);
    try {
      print('Iniciando login com Google...');

      // Verifica se já existe uma sessão ativa
      final currentUser = await _googleSignIn.signInSilently();
      if (currentUser != null) {
        print('Usuário já está logado: ${currentUser.email}');
        await _googleSignIn
            .signOut(); // Força logout para garantir uma nova sessão
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Usuário cancelou o login com Google');
        setState(() => _isLoading = false);
        return;
      }

      print('Conta Google obtida: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print('Token de acesso obtido: ${googleAuth.accessToken}');

      if (googleAuth.accessToken == null) {
        throw Exception('Token de acesso não obtido do Google');
      }

      final authService = Provider.of<AuthService>(context, listen: false);
      final token = await authService.loginWithGoogle(googleAuth.accessToken!);

      setState(() => _isLoading = false);
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('email', googleUser.email);
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        print('Falha no login com Google: token nulo');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Google login failed')));
      }
    } catch (e) {
      setState(() => _isLoading = false);
      print('Erro detalhado no login com Google: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google login error: $e')));
    }
  }

  // Função para login com GitHub
  Future<void> _loginWithGithub(BuildContext context) async {
    setState(() => _isLoading = true);
    try {
      const clientId = 'Ov23liyx7BQ2HxANXlCy';
      const redirectUri = 'comprasapp://oauth/callback';

      final url = Uri.https('github.com', '/login/oauth/authorize', {
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'scope': 'user:email',
        'state': DateTime.now().millisecondsSinceEpoch.toString(),
      });

      print('Iniciando autenticação GitHub com URL: $url');

      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: 'comprasapp',
      );

      if (result == null) {
        throw Exception('Autenticação cancelada');
      }

      print('GitHub Auth Result: $result');

      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) {
        throw Exception('No code received from GitHub');
      }

      print('GitHub Code: $code');

      final authService = Provider.of<AuthService>(context, listen: false);
      final token = await authService.loginWithGithub(code);

      setState(() => _isLoading = false);
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('GitHub login failed')));
      }
    } catch (e) {
      setState(() => _isLoading = false);
      print('GitHub Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('GitHub login error: $e')));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.login),
        backgroundColor: const Color(0xFFF2D4AE),
      ),
      body: Stack(
        children: [
          const ParticleBackground(
            backgroundColor: Color.fromARGB(255, 248, 211, 211),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: localizations.email,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return localizations.enterEmail;
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                        return localizations.invalidEmail;
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: localizations.password,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return localizations.enterPassword;
                      if (value.length < 6)
                        return localizations.passwordTooShort;
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : () => _login(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAEBF8A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                            : Text(
                              localizations.loginButton,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                  const SizedBox(height: 16),
                  // Botão de Login com Google
                  ElevatedButton.icon(
                    onPressed:
                        _isLoading ? null : () => _loginWithGoogle(context),
                    icon: const Icon(Icons.g_mobiledata, color: Colors.black),
                    label: const Text(
                      'Login com Google',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Botão de Login com GitHub
                  ElevatedButton.icon(
                    onPressed:
                        _isLoading ? null : () => _loginWithGithub(context),
                    icon: const Icon(Icons.code, color: Colors.black),
                    label: const Text(
                      'Login com GitHub',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      localizations.noAccountRegister,
                      style: const TextStyle(color: Colors.black),
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
