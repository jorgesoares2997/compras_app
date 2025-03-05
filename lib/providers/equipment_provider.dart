import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../models/equipments.dart';
import '../services/api_service.dart'; // Ajuste o caminho conforme sua estrutura

class EquipmentProvider with ChangeNotifier {
  List<Equipment> _equipments = [];
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? _errorMessage;

  List<Equipment> get equipments => _equipments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Buscar equipamentos
  Future<void> fetchEquipments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _equipments = await _apiService.fetchEquipments();
      developer.log(
        'Equipments fetched successfully: ${_equipments.length} items',
        name: 'EquipmentProvider',
      );
    } catch (e) {
      _errorMessage = e.toString();
      developer.log(
        'Failed to fetch equipments: $e',
        name: 'EquipmentProvider',
        error: e,
      );
      _equipments = []; // Limpa a lista em caso de erro
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Adicionar equipamento
  Future<void> addEquipment(Equipment equipment) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.addEquipment(equipment);
      // Após adicionar com sucesso, atualiza a lista local
      _equipments.add(equipment);
      developer.log(
        'Equipment added and list updated: ${equipment.title}',
        name: 'EquipmentProvider',
      );
    } catch (e) {
      _errorMessage = e.toString();
      developer.log(
        'Failed to add equipment: $e',
        name: 'EquipmentProvider',
        error: e,
      );
      // Não adiciona à lista local em caso de erro
      rethrow; // Propaga o erro para tratamento na UI, se necessário
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
