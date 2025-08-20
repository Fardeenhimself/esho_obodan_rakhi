// class Surah {
//   final int number;
//   final String name;
//   final String englishName;
//   final String englishNameTranslation;
//   final String revelationType;

//   Surah({
//     required this.number,
//     required this.name,
//     required this.englishName,
//     required this.englishNameTranslation,
//     required this.revelationType,
//   });

//   // Deserialization
//   factory Surah.fromJson(Map<String, dynamic> json) {
//     return Surah(
//       number: json['number'],
//       name: json['name'],
//       englishName: json['englishName'],
//       englishNameTranslation: json['englishNameTranslation'],
//       revelationType: json['revelationType'],
//     );
//   }
// }
import 'package:islamic_app/models/ayahs.dart';

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<Ayahs> ayahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.ayahs,
  });

  factory Surah.fromJson({
    required Map<String, dynamic> arabic,
    required Map<String, dynamic> bangla,
  }) {
    final arabicAyahs = arabic['ayahs'] as List;
    final banglaAyahs = bangla['ayahs'] as List;

    final ayahs = List.generate(
      arabicAyahs.length,
      (i) => Ayahs.fromJson(arabic: arabicAyahs[i], bangla: banglaAyahs[i]),
    );

    return Surah(
      number: arabic['number'],
      name: arabic['name'],
      englishName: arabic['englishName'],
      englishNameTranslation: arabic['englishNameTranslation'],
      revelationType: arabic['revelationType'],
      ayahs: ayahs,
    );
  }
}
