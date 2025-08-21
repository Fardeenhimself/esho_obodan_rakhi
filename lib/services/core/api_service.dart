import 'dart:convert';

//import 'package:islamic_app/models/ayahs.dart';
import 'package:islamic_app/models/sura.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/surah_detail.dart';

class QuranApiService {
  static const String _base = 'https://alquran-api.pages.dev/api/quran';

  final http.Client _client;

  QuranApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetch all surahs — translation field respects lang (bn/en)
  Future<List<AllSurahs>> fetchSurahList({required String lang}) async {
    final uri = Uri.parse('$_base?lang=$lang');
    final res = await _client.get(uri);

    if (res.statusCode != 200) {
      throw Exception('Failed to load surahs: ${res.statusCode}');
    }

    final body = json.decode(res.body) as Map<String, dynamic>;
    final list = (body['surahs'] as List).cast<Map<String, dynamic>>();
    return list.map((e) => AllSurahs.fromJson(e)).toList();
  }

  /// Fetch single surah with verses — translation field respects lang (bn/en)
  Future<SurahDetail> fetchSurahDetail({
    required int surahId,
    required String lang,
  }) async {
    final uri = Uri.parse('$_base/surah/$surahId?lang=$lang');
    final res = await _client.get(uri);

    if (res.statusCode != 200) {
      throw Exception('Failed to load surah $surahId: ${res.statusCode}');
    }

    final body = json.decode(res.body) as Map<String, dynamic>;
    return SurahDetail.fromJson(body);
  }
}

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

// class ApiService {
//   final client = http.Client();

//   Future<List<Surah>> fetchQuran() async {
//     final arabicRes = await client.get(
//       Uri.parse('https://api.alquran.cloud/v1/quran'),
//     );
//     final banglaRes = await client.get(
//       Uri.parse('https://api.alquran.cloud/v1/quran/bn.bengali'),
//     );

//     if (arabicRes.statusCode != 200 || banglaRes.statusCode != 200) {
//       throw Exception("Failed to load Quran");
//     }

//     final arabicData = json.decode(arabicRes.body)['data']['surahs'] as List;
//     final banglaData = json.decode(banglaRes.body)['data']['surahs'] as List;

//     return List.generate(
//       arabicData.length,
//       (i) => Surah.fromJson(arabic: arabicData[i], bangla: banglaData[i]),
//     );
//   }
// }
