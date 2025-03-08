import 'package:flutter/material.dart';
import '../models/equipments.dart';
import '../models/report.dart';
import '../services/api_service.dart';

class EquipmentProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Equipment> _equipments = [];
  List<Report> _reports = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Equipment> get equipments => _equipments;
  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> addEquipment(Equipment equipment) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _apiService.addEquipment(equipment);
      _equipments.add(equipment); // Adiciona localmente após sucesso na API
      _isLoading = false;
      _errorMessage = null;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      rethrow; // Propaga a exceção para o AddEquipmentScreen
    } finally {
      notifyListeners();
    }
  }

  Future<void> addReport(Report report) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Simulação de adição (substitua por lógica real, ex.: API)
      await Future.delayed(const Duration(seconds: 1));
      _reports.add(report);
      _isLoading = false;
      _errorMessage = null;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> fetchEquipments() async {
    _isLoading = true;
    notifyListeners();
    try {
      _equipments = await _apiService.fetchEquipments();
      _isLoading = false;
      _errorMessage = null;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
