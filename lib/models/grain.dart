class Grain {
  final String name;
  final double density; // kg/m3

  const Grain({required this.name, required this.density});

  static const List<Grain> defaultGrains = [
    Grain(name: 'Pszenica', density: 750),
    Grain(name: 'Żyto', density: 700),
    Grain(name: 'Jęczmień', density: 620),
    Grain(name: 'Kukurydza', density: 720),
    Grain(name: 'Rzepak', density: 670),
    Grain(name: 'Owies', density: 450),
  ];
}
