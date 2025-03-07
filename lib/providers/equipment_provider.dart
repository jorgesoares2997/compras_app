import 'package:flutter/material.dart';
import '../models/equipments.dart';
import '../models/report.dart';

class EquipmentProvider with ChangeNotifier {
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
      // Simulação de adição (substitua por sua lógica real, ex.: API ou banco de dados)
      await Future.delayed(const Duration(seconds: 1));
      _equipments.add(equipment);
      _isLoading = false;
      _errorMessage = null;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> addReport(Report report) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Simulação de adição (substitua por sua lógica real)
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

  void fetchEquipments() {}
}
