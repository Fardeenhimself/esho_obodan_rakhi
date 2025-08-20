class Sura {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;

  Sura({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
  });

  // Deserialization
  factory Sura.fromJson(Map<String, dynamic> json) {
    return Sura(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      revelationType: json['revelationType'],
    );
  }
}
