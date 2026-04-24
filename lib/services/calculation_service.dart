import 'dart:math';

class CalculationService {
  static double calculateCylinderVolume(double radius, double height) {
    return pi * pow(radius, 2) * height;
  }

  static double calculateConeVolume(double radius, double height) {
    return (1 / 3) * pi * pow(radius, 2) * height;
  }

  static double calculateTotalTonnage(
    double radius,
    double cylinderHeight,
    double hopperHeight,
    double density,
  ) {
    double volume =
        calculateCylinderVolume(radius, cylinderHeight) +
        calculateConeVolume(radius, hopperHeight);
    return (volume * density) / 1000;
  }
}
