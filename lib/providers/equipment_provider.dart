import 'package:compras_app/services/report_service.dart';
import 'package:flutter/material.dart';

import 'package:compras_app/models/equipments.dart';
import 'package:compras_app/models/report.dart';
import 'package:compras_app/services/auth_service.dart';

class EquipmentProvider with ChangeNotifier {
  final ReportService _reportService;
  List<Equipment> _equipments = [];
  List<Report> _reports = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Equipment> get equipments => _equipments;
  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  EquipmentProvider(AuthService authService) : _reportService = ReportService();

  Future<void> addEquipment(Equipment equipment) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulação (adicione endpoint na API se necessário)
      await Future.delayed(const Duration(seconds: 1));
      _equipments.add(equipment);
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

  Future<void> fetchReports() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
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

  Future<void> fetchEquipments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulação (adicione endpoint na API se necessário)
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
