import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl =
      'https://compras-auth.onrender.com/api/auth'; // URL do seu serviço de autenticação
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Autenticação biométrica
  Future<bool> authenticate() async {
    try {
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true, // Força apenas biometria, se suportado
        ),
      );
      return isAuthenticated;
    } catch (e) {
      print('Erro na autenticação biométrica: $e');
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
      rethrow;
    }
  }

  // Login de usuário (email e senha)
  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print('Login - Status: ${response.statusCode}, Body: ${response.body}');
      if (response.statusCode == 200) {
        final token = response.body.trim();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return token;
      } else {
        throw Exception(
          'Erro ao fazer login: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Erro no login: $e');
      return null;
    }
  }

  // Login com Google
  Future<String?> loginWithGoogle(String accessToken) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$_baseUrl/google-login',
        ), // Endpoint do seu backend para Google
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'access_token': accessToken}),
      );
      print(
        'Google Login - Status: ${response.statusCode}, Body: ${response.body}',
      );
      if (response.statusCode == 200) {
        final token =
            jsonDecode(
              response.body,
            )['token']; // Ajuste conforme a resposta do seu backend
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return token;
      } else {
        throw Exception(
          'Erro ao fazer login com Google: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Erro no login com Google: $e');
      return null;
    }
  }

  // Login com Apple
  Future<String?> loginWithApple(String identityToken) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$_baseUrl/apple-login',
        ), // Endpoint do seu backend para Apple
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identity_token': identityToken}),
      );
      print(
        'Apple Login - Status: ${response.statusCode}, Body: ${response.body}',
      );
      if (response.statusCode == 200) {
        final token =
            jsonDecode(
              response.body,
            )['token']; // Ajuste conforme a resposta do seu backend
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return token;
      } else {
        throw Exception(
          'Erro ao fazer login com Apple: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Erro no login com Apple: $e');
      return null;
    }
  }

  // Obter token salvo
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
