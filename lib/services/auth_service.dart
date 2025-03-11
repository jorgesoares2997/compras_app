import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl =
      'https://compras-auth.onrender.com/api/auth'; // URL do seu serviço de autenticação
  final LocalAuthentication _localAuth = LocalAuthentication();
  Future<bool> authenticate() async {
    try {
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: AuthenticationOptions(
          biometricOnly: true, // Se for uma versão que permita este parâmetro
        ),
      );
      return isAuthenticated;
    } catch (e) {
      return false;
    }
  }

  // Registro de usuário
  Future<bool> register(String email, String password, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'name': name}),
      );
      print(
        'Register - Status: ${response.statusCode}, Body: ${response.body}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Erro ao registrar: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Erro no registro: $e');
      rethrow; // Repassa o erro pra ser tratado na UI
    }
  }

  // Login de usuário
  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print('Login - Status: ${response.statusCode}, Body: ${response.body}');
      if (response.statusCode == 200) {
        final token =
            response.body.trim(); // Remove espaços ou quebras de linha
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token); // Padronizei como 'token'
        return token;
      } else {
        throw Exception(
          'Erro ao fazer login: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Erro no login: $e');
      return null; // Retorna null em caso de erro
    }
  }

  // Obter token salvo
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Padronizei como 'token'
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Padronizei como 'token'
  }
}
