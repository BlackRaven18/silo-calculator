class Grain {
  final String name;
  final double density; // kg/m3

  const Grain({required this.name, required this.density});

  static const List<Grain> defaultGrains = [
    Grain(name: 'Pszenica', density: 770),
    Grain(name: 'Żyto', density: 700),
    Grain(name: 'Jęczmień', density: 620),
    Grain(name: 'Owies', density: 480),
    Grain(name: 'Rzepak', density: 690),
    Grain(name: 'Kukurydza', density: 650),
    Grain(name: 'Łubin', density: 770),
    Grain(name: 'Pszenżyto', density: 700),
    Grain(name: 'Pellet', density: 590),
    Grain(name: 'Owies dla koni', density: 520),
    Grain(name: 'Śruta rzepakowa', density: 530),
    Grain(name: 'Mieszanka paszowa', density: 520),
    Grain(name: 'Groch', density: 800),
    Grain(name: 'Ziarno śrutowane', density: 600),
    Grain(name: 'Superfosfat', density: 1150),
    Grain(name: 'Mocznik', density: 760),
    Grain(name: 'Inny', density: 0),
  ];
}
