class Verse {
  final int id; // in-surah verse number (1..n)
  final String arabic; // "text"
  final String meaning; // "translation" in chosen lang

  Verse({required this.id, required this.arabic, required this.meaning});

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json['id'] as int,
      arabic: json['text'] as String,
      meaning: json['translation'] as String,
    );
  }
}
