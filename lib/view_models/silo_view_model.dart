import 'package:flutter/material.dart';
import '../models/grain.dart';
import '../models/silo.dart';
import '../services/calculation_service.dart';

enum SiloDimension { none, radius, cylinderHeight, hopperHeight }

class SiloViewModel extends ChangeNotifier {
  double _radius = 1.15;
  double _cylinderHeight = 2.85;
  double _hopperHeight = 0.95;
  Grain _selectedGrain = Grain.defaultGrains[0];
  late double _customDensity;
  SiloDimension _focusedDimension = SiloDimension.none;

  SiloViewModel() {
    _customDensity = _selectedGrain.density;
  }

  final List<Silo> _savedSilos = [];

  double get radius => _radius;
  double get cylinderHeight => _cylinderHeight;
  double get hopperHeight => _hopperHeight;
  Grain get selectedGrain => _selectedGrain;
  double get customDensity => _customDensity;
  SiloDimension get focusedDimension => _focusedDimension;
  List<Silo> get savedSilos => _savedSilos;

  double get totalVolume =>
      CalculationService.calculateCylinderVolume(_radius, _cylinderHeight) +
      CalculationService.calculateConeVolume(_radius, _hopperHeight);

  double get cylinderVolume =>
      CalculationService.calculateCylinderVolume(_radius, _cylinderHeight);
  double get hopperVolume =>
      CalculationService.calculateConeVolume(_radius, _hopperHeight);

  double get totalTonnage => (totalVolume * _customDensity) / 1000;
  double get cylinderTonnage => (cylinderVolume * _customDensity) / 1000;
  double get hopperTonnage => (hopperVolume * _customDensity) / 1000;

  void updateRadius(double value) {
    _radius = value;
    notifyListeners();
  }

  void updateCylinderHeight(double value) {
    _cylinderHeight = value;
    notifyListeners();
  }

  void updateHopperHeight(double value) {
    _hopperHeight = value;
    notifyListeners();
  }

  void updateGrain(Grain grain) {
    _selectedGrain = grain;
    _customDensity = grain.density;
    notifyListeners();
  }

  void updateDensity(double density) {
    _customDensity = density;
    notifyListeners();
  }

  void saveCurrentSilo() {
    final newSilo = Silo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Silos ${_savedSilos.length + 1}',
      radius: _radius,
      cylinderHeight: _cylinderHeight,
      hopperHeight: _hopperHeight,
      grainName: _selectedGrain.name,
      tonnage: totalTonnage,
    );
    _savedSilos.add(newSilo);
    notifyListeners();
  }

  void deleteSilo(String id) {
    _savedSilos.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  void setFocusedDimension(SiloDimension dimension) {
    if (_focusedDimension != dimension) {
      _focusedDimension = dimension;
      notifyListeners();
    }
  }
}
