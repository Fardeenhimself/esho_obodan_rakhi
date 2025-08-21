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
