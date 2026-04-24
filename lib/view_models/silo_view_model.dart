import 'package:flutter/material.dart';
import '../models/grain.dart';
import '../models/silo.dart';
import '../services/calculation_service.dart';
import '../core/services/storage_service.dart';

enum SiloDimension { none, radius, cylinderHeight, hopperHeight }

class SiloViewModel extends ChangeNotifier {
  double _radius = 1.15;
  double _cylinderHeight = 2.85;
  double _hopperHeight = 0.95;
  double _fillLevel = 0.5; // 0.0 to 1.0
  Grain _selectedGrain = Grain.defaultGrains[0];
  late double _customDensity;
  SiloDimension _focusedDimension = SiloDimension.none;

  SiloViewModel() {
    _customDensity = _selectedGrain.density;
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final loadedSilos = await StorageService.loadSilos();
    if (loadedSilos.isNotEmpty) {
      _savedSilos.clear();
      _savedSilos.addAll(loadedSilos);
      notifyListeners();
    }
  }

  void _saveToStorage() {
    StorageService.saveSilos(_savedSilos);
  }

  final List<Silo> _savedSilos = [];
  String? _selectedSiloId;

  double get radius => _radius;
  double get cylinderHeight => _cylinderHeight;
  double get hopperHeight => _hopperHeight;
  double get fillLevel => _fillLevel;
  Grain get selectedGrain => _selectedGrain;
  double get customDensity => _customDensity;
  SiloDimension get focusedDimension => _focusedDimension;
  List<Silo> get savedSilos => _savedSilos;
  String? get selectedSiloId => _selectedSiloId;

  Silo? get selectedSilo => _selectedSiloId == null
      ? null
      : _savedSilos.firstWhere((s) => s.id == _selectedSiloId);

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

  // Fill level calculations
  double get filledVolume {
    final totalHeight = _cylinderHeight + _hopperHeight;
    final filledHeight = _fillLevel * totalHeight;

    if (filledHeight <= _hopperHeight) {
      // Only in hopper
      final currentRadius = _radius * (filledHeight / _hopperHeight);
      return CalculationService.calculateConeVolume(
        currentRadius,
        filledHeight,
      );
    } else {
      // Hopper is full + some cylinder
      final cylinderFilledHeight = filledHeight - _hopperHeight;
      final hopperVol = CalculationService.calculateConeVolume(
        _radius,
        _hopperHeight,
      );
      final cylinderVol = CalculationService.calculateCylinderVolume(
        _radius,
        cylinderFilledHeight,
      );
      return hopperVol + cylinderVol;
    }
  }

  double get filledTonnage => (filledVolume * _customDensity) / 1000;

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

  void updateFillLevel(double level) {
    _fillLevel = level.clamp(0.0, 1.0);
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

  void saveCurrentSilo({String? name}) {
    final finalName = (name == null || name.isEmpty)
        ? 'Silos ${_savedSilos.length + 1}'
        : name;

    final newSilo = Silo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: finalName,
      radius: _radius,
      cylinderHeight: _cylinderHeight,
      hopperHeight: _hopperHeight,
      grainName: _selectedGrain.name,
      tonnage: filledTonnage,
      maxTonnage: totalTonnage,
      fillLevel: _fillLevel,
    );
    _savedSilos.add(newSilo);
    _selectedSiloId = newSilo.id;
    _saveToStorage();
    notifyListeners();
  }

  void updateSelectedSilo() {
    if (_selectedSiloId == null) return;
    final index = _savedSilos.indexWhere((s) => s.id == _selectedSiloId);
    if (index != -1) {
      final oldSilo = _savedSilos[index];
      _savedSilos[index] = Silo(
        id: oldSilo.id,
        name: oldSilo.name,
        radius: _radius,
        cylinderHeight: _cylinderHeight,
        hopperHeight: _hopperHeight,
        grainName: _selectedGrain.name,
        tonnage: filledTonnage,
        maxTonnage: totalTonnage,
        fillLevel: _fillLevel,
      );
      _saveToStorage();
      notifyListeners();
    }
  }

  void loadSilo(Silo silo) {
    _radius = silo.radius;
    _cylinderHeight = silo.cylinderHeight;
    _hopperHeight = silo.hopperHeight;
    _fillLevel = silo.fillLevel;

    try {
      _selectedGrain = Grain.defaultGrains.firstWhere(
        (g) => g.name == silo.grainName,
      );
      _customDensity = _selectedGrain.density;
    } catch (_) {}

    _selectedSiloId = silo.id;
    notifyListeners();
  }

  void createNewSilo() {
    _selectedSiloId = null;
    notifyListeners();
  }

  void deleteSilo(String id) {
    if (_selectedSiloId == id) {
      _selectedSiloId = null;
    }
    _savedSilos.removeWhere((s) => s.id == id);
    _saveToStorage();
    notifyListeners();
  }

  void renameSelectedSilo(String newName) {
    if (_selectedSiloId == null || newName.isEmpty) return;
    final index = _savedSilos.indexWhere((s) => s.id == _selectedSiloId);
    if (index != -1) {
      final oldSilo = _savedSilos[index];
      _savedSilos[index] = Silo(
        id: oldSilo.id,
        name: newName,
        radius: oldSilo.radius,
        cylinderHeight: oldSilo.cylinderHeight,
        hopperHeight: oldSilo.hopperHeight,
        grainName: oldSilo.grainName,
        tonnage: oldSilo.tonnage,
        maxTonnage: oldSilo.maxTonnage,
        fillLevel: oldSilo.fillLevel,
      );
      _saveToStorage();
      notifyListeners();
    }
  }

  void setFocusedDimension(SiloDimension dimension) {
    if (_focusedDimension != dimension) {
      _focusedDimension = dimension;
      notifyListeners();
    }
  }
}
