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
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString(
            'token',
          ); // Mesmo nome usado no AuthService
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          print("Erro na requisição: ${e.response?.statusCode} - ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> criarRelatorio(Map<String, dynamic> data) async {
    return await _dio.post('/api/relatorios', data: data);
  }

  Future<Response> listarTodosRelatorios() async {
    return await _dio.get('/api/relatorios');
  }

  Future<Response> buscarRelatorioPorId(int id) async {
    return await _dio.get('/api/relatorios/$id');
  }

  Future<Response> buscarRelatoriosPorVoluntario(String nomeVoluntario) async {
    return await _dio.get('/api/relatorios/voluntario/$nomeVoluntario');
  }

  Future<Response> atualizarRelatorio(int id, Map<String, dynamic> data) async {
    return await _dio.put('/api/relatorios/$id', data: data);
  }
}
