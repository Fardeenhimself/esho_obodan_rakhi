import 'dart:convert';

import 'package:islamic_app/models/ayahs.dart';
import 'package:islamic_app/models/sura.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // API OF QURAN
  Future<List<Surah>> fetchQuran() async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/quran/bn.bengali'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final surahs = data['data']['surahs'] as List;

      return surahs.map((e) => Surah.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Quran');
    }
  }

  // API OF EACH SURAH's AYAHS
  Future<List<Ayahs>> fetchSurahAyahs(int surahNumber) async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/surah/$surahNumber/bn.bengali'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final ayahs = data['data']['ayahs'] as List;

      return ayahs.map((e) => Ayahs.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Surah');
    }
  }
}
