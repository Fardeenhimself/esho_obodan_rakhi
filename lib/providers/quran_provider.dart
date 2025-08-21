import 'package:islamic_app/models/sura.dart';
import 'package:islamic_app/models/surah_detail.dart';
import 'package:islamic_app/services/core/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/services/database/quran_cache.dart';

// Enums
enum TranslationLang { bn, en }

extension TranslationLangX on TranslationLang {
  String get code => this == TranslationLang.bn ? 'bn' : 'en';
  String get label => this == TranslationLang.bn ? 'Bengali' : 'English';
}

// Extension will allow us to use label instead of code where we are using the enum values.
// making it more human readable around the code base.
// Like if we create a varaible of the probider called langSelector. Instead of
// langSelector.en we can use langSeelctor.label that will call the label according to selected version...

/// Selected language provider (defaults to Bengali)
final translationLangProvider = StateProvider<TranslationLang>(
  (_) => TranslationLang.bn,
);

// API service provider
final quranApiProvider = Provider<QuranApiService>((_) => QuranApiService());

// Cache provider
final quranCacheRepoProvider = Provider<QuranCacheRepo>(
  (_) => QuranCacheRepo(),
);

// Surah list: first cache, else request api, then cache update...
final surahListProvider = FutureProvider<List<AllSurahs>>((ref) async {
  final api = ref.watch(quranApiProvider);
  final repo = ref.watch(quranCacheRepoProvider);
  final lang = ref.watch(translationLangProvider).code;

  // 1) Try cache
  final cached = await repo.getSurahList(lang);
  if (cached.isNotEmpty) return cached;

  // 2) Fetch & cache
  final remote = await api.fetchSurahList(lang: lang);
  await repo.upsertSurahList(lang, remote);
  return remote;
});

// Surah detail — first cache, else request api, then cache update  family by suraID...

final surahDetailProvider = FutureProvider.family<SurahDetail, int>((
  ref,
  surahId,
) async {
  final api = ref.watch(quranApiProvider);
  final repo = ref.watch(quranCacheRepoProvider);
  final lang = ref.watch(translationLangProvider).code;

  // 1) Try cache
  final cached = await repo.getSurahDetail(surahId, lang);
  if (cached != null && cached.verses.isNotEmpty) return cached;

  // 2) Fetch & cache
  final remote = await api.fetchSurahDetail(surahId: surahId, lang: lang);
  await repo.upsertSurahDetail(lang, remote);

  // Return freshly saved detail (or remote directly)
  return remote;
});
