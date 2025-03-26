import 'package:compras_app/models/equipments.dart';
import 'package:compras_app/services/api_service.dart';
import 'package:flutter/material.dart';

class EquipmentProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Equipment> _equipments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Equipment> get equipments => _equipments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  EquipmentProvider();

  get error => null;

  Future<void> fetchEquipments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _equipments = await _apiService.fetchEquipments();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addEquipment(Equipment equipment) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newEquipment = await _apiService.addEquipment(equipment);
      _equipments.add(newEquipment);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateEquipment(Equipment equipment) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedEquipment = await _apiService.updateEquipment(equipment);
      final index = _equipments.indexWhere((e) => e.id == updatedEquipment.id);
      if (index != -1) {
        _equipments[index] = updatedEquipment;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEquipment(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.deleteEquipment(id);
      _equipments.removeWhere((e) => e.id == id);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
