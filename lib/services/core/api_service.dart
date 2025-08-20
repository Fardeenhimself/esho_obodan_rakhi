import 'dart:convert';

import 'package:islamic_app/models/ayahs.dart';
import 'package:islamic_app/models/sura.dart';
import 'package:http/http.dart' as http;

// class ApiService {
//   // API OF QURAN
//   Future<List<Surah>> fetchQuran() async {
//     final response = await http.get(
//       Uri.parse('https://api.alquran.cloud/v1/surah'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final surahs = data['data'] as List;

//       return surahs.map((e) => Surah.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load Quran');
//     }
//   }

//   // API OF EACH SURAH's AYAHS
//   Future<List<Ayahs>> fetchSurahAyahs(int surahNumber) async {
//     final response = await http.get(
//       Uri.parse('https://api.alquran.cloud/v1/surah/$surahNumber'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final ayahs = data['data']['ayahs'] as List;

//       return ayahs.map((e) => Ayahs.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load Surah');
//     }
//   }
// }

class ApiService {
  final client = http.Client();

  Future<List<Surah>> fetchQuran() async {
    final arabicRes = await client.get(
      Uri.parse('https://api.alquran.cloud/v1/quran'),
    );
    final banglaRes = await client.get(
      Uri.parse('https://api.alquran.cloud/v1/quran/bn.bengali'),
    );

    if (arabicRes.statusCode != 200 || banglaRes.statusCode != 200) {
      throw Exception("Failed to load Quran");
    }

    final arabicData = json.decode(arabicRes.body)['data']['surahs'] as List;
    final banglaData = json.decode(banglaRes.body)['data']['surahs'] as List;

    return List.generate(
      arabicData.length,
      (i) => Surah.fromJson(arabic: arabicData[i], bangla: banglaData[i]),
    );
  }
}
