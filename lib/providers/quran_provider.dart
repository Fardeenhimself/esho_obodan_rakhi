import 'package:islamic_app/models/ayahs.dart';
import 'package:islamic_app/models/sura.dart';
import 'package:islamic_app/services/core/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final quranProvider = FutureProvider<List<Surah>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return api.fetchQuran();
});

// final surahAyahsProvider = FutureProvider.family<List<Ayahs>, int>((
//   ref,
//   surahNumber,
// ) async {
//   final api = ref.watch(apiServiceProvider);
//   return api.fetchSurahAyahs(surahNumber);
// });
