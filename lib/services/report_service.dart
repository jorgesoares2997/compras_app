import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportService {
  final Dio _dio;
  static const String baseUrl =
      "https://reports-api-ru9g.onrender.com"; // URL da API de relatórios

  ReportService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 120),
          validateStatus: (status) {
            return status != null &&
                status < 500; // Aceita status < 500 como sucesso
          },
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          print("Preparando requisição...");
          print("Método: ${options.method}");
          print("URL completa: ${options.uri}");
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
            print("Token enviado: $token");
          } else {
            print("Nenhum token encontrado no SharedPreferences");
          }
          print("Headers: ${options.headers}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("Resposta recebida: ${response.statusCode}");
          print("Dados da resposta: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("Erro na requisição: ${e.response?.statusCode} - ${e.message}");
          if (e.response != null) {
            print("Detalhes do erro: ${e.response?.data}");
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> criarRelatorio(Map<String, dynamic> data) async {
    try {
      return await _dio.post('/api/relatorios', data: data);
    } catch (e) {
      print("Erro ao criar relatório: $e");
      rethrow;
    }
  }

  Future<Response> listarTodosRelatorios() async {
    try {
      return await _dio.get('/api/relatorios');
    } catch (e) {
      print("Erro ao listar relatórios: $e");
      rethrow;
    }
  }

  Future<Response> buscarRelatorioPorId(int id) async {
    try {
      return await _dio.get('/api/relatorios/$id');
    } catch (e) {
      print("Erro ao buscar relatório por ID: $e");
      rethrow;
    }
  }

  Future<Response> buscarRelatoriosPorVoluntario(String nomeVoluntario) async {
    try {
      return await _dio.get('/api/relatorios/voluntario/$nomeVoluntario');
    } catch (e) {
      print("Erro ao buscar relatórios por voluntário: $e");
      rethrow;
    }
  }

  Future<Response> atualizarRelatorio(int id, Map<String, dynamic> data) async {
    try {
      return await _dio.put('/api/relatorios/$id', data: data);
    } catch (e) {
      print("Erro ao atualizar relatório: $e");
      rethrow;
    }
  }
}
