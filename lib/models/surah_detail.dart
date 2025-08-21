import 'package:islamic_app/models/verse.dart';

class SurahDetail {
  final int id;
  final String name;
  final String transliteration;
  final String translation;
  final String type;
  final int totalVerses;
  final Map<String, dynamic> audio;
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

  // deserialization
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

  // Convert to Map for SQLite (excluding verses)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'transliteration': transliteration,
      'translation': translation,
      'type': type,
      'total_verses': totalVerses,
      'audio': audio.toString(),
    };
  }
}
