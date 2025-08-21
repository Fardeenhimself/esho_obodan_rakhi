class Verse {
  final int id;
  final String arabic;
  final String meaning;

  Verse({required this.id, required this.arabic, required this.meaning});

  // deserialization
  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json['id'] as int,
      arabic: json['text'] as String,
      meaning: json['translation'] as String,
    );
  }

  // Convert to Map for SQLite
  Map<String, dynamic> toMap(int surahId) {
    return {
      'id': id,
      'surah_id': surahId,
      'arabic': arabic,
      'meaning': meaning,
    };
  }
}
