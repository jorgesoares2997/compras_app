import 'dart:convert';
import 'dart:developer' as developer; // Para logar no console
import 'package:compras_app/models/equipments.dart'; // Ajustei o caminho do modelo
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://backend-compras.onrender.com/api';

  // Listar equipamentos
  Future<List<Equipment>> fetchEquipments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/courses'));

      // Log da requisição
      developer.log(
        'Fetching equipments from $baseUrl/courses',
        name: 'ApiService',
      );
      developer.log('Status Code: ${response.statusCode}', name: 'ApiService');

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        developer.log('Response body: ${response.body}', name: 'ApiService');
        return jsonResponse.map((data) => Equipment.fromJson(data)).toList();
      } else {
        // Tratamento de erro baseado no status HTTP
        String errorMessage;
        switch (response.statusCode) {
          case 404:
            errorMessage = 'Endpoint não encontrado (404)';
            break;
          case 500:
            errorMessage = 'Erro no servidor (500)';
            break;
          default:
            errorMessage =
                'Falha ao carregar equipamentos: ${response.statusCode}';
        }
        developer.log(errorMessage, name: 'ApiService', error: response.body);
        throw Exception(errorMessage);
      }
    } catch (e, stackTrace) {
      // Captura erros inesperados (ex.: problemas de rede ou JSON inválido)
      developer.log(
        'Erro ao buscar equipamentos: $e',
        name: 'ApiService',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Erro ao buscar equipamentos: $e');
    }
  }

  // Adicionar equipamento
  Future<void> addEquipment(Equipment equipment) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/courses'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(equipment.toJson()),
      );

      // Log da requisição
      developer.log('Adding equipment to $baseUrl/courses', name: 'ApiService');
      developer.log(
        'Request body: ${json.encode(equipment.toJson())}',
        name: 'ApiService',
      );
      developer.log('Status Code: ${response.statusCode}', name: 'ApiService');

      if (response.statusCode == 201) {
        developer.log('Equipment added successfully', name: 'ApiService');
      } else {
        // Tratamento de erro baseado no status HTTP
        String errorMessage;
        switch (response.statusCode) {
          case 400:
            errorMessage =
                'Requisição inválida (400): Dados enviados incorretos';
            break;
          case 500:
            errorMessage = 'Erro no servidor (500)';
            break;
          default:
            errorMessage =
                'Falha ao adicionar equipamento: ${response.statusCode}';
        }
        developer.log(errorMessage, name: 'ApiService', error: response.body);
        throw Exception(errorMessage);
      }
    } catch (e, stackTrace) {
      // Captura erros inesperados
      developer.log(
        'Erro ao adicionar equipamento: $e',
        name: 'ApiService',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Erro ao adicionar equipamento: $e');
    }
  }

  // Atualizar e deletar podem ser adicionados depois, seguindo o mesmo padrão
}
