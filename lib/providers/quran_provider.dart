import 'package:islamic_app/models/sura.dart';
import 'package:islamic_app/models/surah_detail.dart';
import 'package:islamic_app/services/core/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

/// API service provider
final quranApiProvider = Provider<QuranApiService>((_) => QuranApiService());

/// Surah list — rebuilds when lang changes
final surahListProvider = FutureProvider<List<AllSurahs>>((ref) async {
  final api = ref.watch(quranApiProvider);
  final lang = ref.watch(translationLangProvider).code;
  return api.fetchSurahList(lang: lang);
});

/// Surah detail — depends on lang; family by surahId
final surahDetailProvider = FutureProvider.family<SurahDetail, int>((
  ref,
  surahId,
) async {
  final api = ref.watch(quranApiProvider);
  final lang = ref.watch(translationLangProvider).code;
  return api.fetchSurahDetail(surahId: surahId, lang: lang);
});
