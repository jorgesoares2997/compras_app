import 'dart:convert';
import 'dart:developer' as developer;
import 'package:compras_app/models/equipments.dart'; // Caminho do modelo
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://backend-compras.onrender.com/api';

  // Listar equipamentos
  Future<List<Equipment>> fetchEquipments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/courses'));

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
        String errorMessage;
        switch (response.statusCode) {
          case 404:
            errorMessage = 'Nenhum equipamento encontrado (404)';
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
  Future<Equipment> addEquipment(Equipment equipment) async {
    try {
      // Validação mínima antes de enviar (title e price são obrigatórios no backend)
      if (equipment.title == null || equipment.title!.isEmpty) {
        throw Exception('O título é obrigatório');
      }
      if (equipment.price == null) {
        throw Exception('O preço é obrigatório');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/courses'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(equipment.toJson()),
      );

      developer.log('Adding equipment to $baseUrl/courses', name: 'ApiService');
      developer.log(
        'Request body: ${json.encode(equipment.toJson())}',
        name: 'ApiService',
      );
      developer.log('Status Code: ${response.statusCode}', name: 'ApiService');

      if (response.statusCode == 201) {
        developer.log('Equipment added successfully', name: 'ApiService');
        final jsonResponse = json.decode(response.body);
        return Equipment.fromJson(
          jsonResponse,
        ); // Retorna o equipamento criado com ID
      } else {
        String errorMessage;
        switch (response.statusCode) {
          case 400:
            errorMessage =
                'Requisição inválida (400): Verifique os dados enviados';
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
      developer.log(
        'Erro ao adicionar equipamento: $e',
        name: 'ApiService',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Erro ao adicionar equipamento: $e');
    }
  }

  // Atualizar equipamento
  Future<Equipment> updateEquipment(Equipment equipment) async {
    try {
      if (equipment.id == null) {
        throw Exception('ID do equipamento é necessário para atualização');
      }
      if (equipment.title == null || equipment.title!.isEmpty) {
        throw Exception('O título é obrigatório');
      }
      if (equipment.price == null) {
        throw Exception('O preço é obrigatório');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/courses/${equipment.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(equipment.toJson()),
      );

      developer.log(
        'Updating equipment at $baseUrl/courses/${equipment.id}',
        name: 'ApiService',
      );
      developer.log(
        'Request body: ${json.encode(equipment.toJson())}',
        name: 'ApiService',
      );
      developer.log('Status Code: ${response.statusCode}', name: 'ApiService');

      if (response.statusCode == 200) {
        developer.log('Equipment updated successfully', name: 'ApiService');
        final jsonResponse = json.decode(response.body);
        return Equipment.fromJson(
          jsonResponse,
        ); // Retorna o equipamento atualizado
      } else {
        String errorMessage;
        switch (response.statusCode) {
          case 400:
            errorMessage =
                'Requisição inválida (400): Verifique os dados enviados';
            break;
          case 404:
            errorMessage = 'Equipamento não encontrado (404)';
            break;
          case 500:
            errorMessage = 'Erro no servidor (500)';
            break;
          default:
            errorMessage =
                'Falha ao atualizar equipamento: ${response.statusCode}';
        }
        developer.log(errorMessage, name: 'ApiService', error: response.body);
        throw Exception(errorMessage);
      }
    } catch (e, stackTrace) {
      developer.log(
        'Erro ao atualizar equipamento: $e',
        name: 'ApiService',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Erro ao atualizar equipamento: $e');
    }
  }

  // Deletar equipamento
  Future<void> deleteEquipment(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/courses/$id'));

      developer.log(
        'Deleting equipment at $baseUrl/courses/$id',
        name: 'ApiService',
      );
      developer.log('Status Code: ${response.statusCode}', name: 'ApiService');

      if (response.statusCode == 204) {
        developer.log('Equipment deleted successfully', name: 'ApiService');
      } else {
        String errorMessage;
        switch (response.statusCode) {
          case 404:
            errorMessage = 'Equipamento não encontrado (404)';
            break;
          case 500:
            errorMessage = 'Erro no servidor (500)';
            break;
          default:
            errorMessage =
                'Falha ao deletar equipamento: ${response.statusCode}';
        }
        developer.log(errorMessage, name: 'ApiService', error: response.body);
        throw Exception(errorMessage);
      }
    } catch (e, stackTrace) {
      developer.log(
        'Erro ao deletar equipamento: $e',
        name: 'ApiService',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Erro ao deletar equipamento: $e');
    }
  }
}
