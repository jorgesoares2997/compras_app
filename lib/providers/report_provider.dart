import 'package:compras_app/models/report.dart';
import 'package:compras_app/services/auth_service.dart';
import 'package:compras_app/services/report_service.dart';
import 'package:flutter/material.dart';

class ReportProvider with ChangeNotifier {
  final ReportService _reportService;
  final AuthService _authService;
  List<Report> _reports = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ReportProvider(this._reportService, this._authService);

  Future<void> fetchReports() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Usuário não autenticado');
      }
      final response = await _reportService.listarTodosRelatorios();
      if (response.statusCode == 200) {
        _reports =
            (response.data as List)
                .map((json) => Report.fromJson(json))
                .toList();
      } else {
        throw Exception('Falha ao buscar relatórios: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addReport(Report report) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Usuário não autenticado');
      }
      final response = await _reportService.criarRelatorio(report.toJson());
      if (response.statusCode == 200) {
        final newReport = Report.fromJson(response.data);
        _reports.add(newReport);
      } else {
        throw Exception('Falha ao adicionar relatório: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
