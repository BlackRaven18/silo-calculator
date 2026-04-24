class Silo {
  final String id;
  final String name;
  final double radius;
  final double cylinderHeight;
  final double hopperHeight;
  final String grainName;
  final double tonnage;
  final double maxTonnage;
  final double fillLevel;

  Silo({
    required this.id,
    required this.name,
    required this.radius,
    required this.cylinderHeight,
    required this.hopperHeight,
    required this.grainName,
    required this.tonnage,
    required this.maxTonnage,
    required this.fillLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'radius': radius,
      'cylinderHeight': cylinderHeight,
      'hopperHeight': hopperHeight,
      'grainName': grainName,
      'tonnage': tonnage,
      'maxTonnage': maxTonnage,
      'fillLevel': fillLevel,
    };
  }

  factory Silo.fromMap(Map<String, dynamic> map) {
    return Silo(
      id: map['id'],
      name: map['name'],
      radius: map['radius'],
      cylinderHeight: map['cylinderHeight'],
      hopperHeight: map['hopperHeight'],
      grainName: map['grainName'],
      tonnage: map['tonnage'],
      maxTonnage: map['maxTonnage'],
      fillLevel: map['fillLevel'],
    );
  }
}
