import 'package:islamic_app/models/verse.dart';

class SurahDetail {
  final int id;
  final String name; // Arabic
  final String transliteration; // e.g. Al-Fatihah
  final String translation; // depends on lang
  final String type; // meccan/medinan
  final int totalVerses;
  final Map<String, dynamic> audio; // pass-through (optional use)
  final List<Verse> verses;

  SurahDetail({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.translation,
    required this.type,
    required this.totalVerses,
    required this.audio,
    required this.verses,
  });

  factory SurahDetail.fromJson(Map<String, dynamic> json) {
    final versesJson = (json['verses'] as List).cast<Map<String, dynamic>>();
    return SurahDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      transliteration: json['transliteration'] as String,
      translation: json['translation'] as String,
      type: json['type'] as String,
      totalVerses: json['total_verses'] as int,
      audio: (json['audio'] as Map<String, dynamic>?) ?? const {},
      verses: versesJson.map((v) => Verse.fromJson(v)).toList(),
    );
  }
}
