import 'package:islamic_app/models/core_models/sura.dart';
import 'package:islamic_app/models/core_models/surah_detail.dart';
import 'package:islamic_app/models/core_models/verse.dart';
import 'package:sqflite/sqflite.dart';

import 'quran_db.dart';

class QuranCacheRepo {
  // ALL SURAHS
  Future<void> upsertSurahList(String lang, List<AllSurahs> list) async {
    final db = await QuranDb.instance;
    final batch = db.batch();
    for (final s in list) {
      batch.insert('surahs', {
        'id': s.id,
        'name': s.name,
        'transliteration': s.transliteration,
        'type': s.type,
        'total_verses': s.totalVerses,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      // Per-language translation for list view
      batch.insert('surah_translation', {
        'surah_id': s.id,
        'lang': lang,
        'translation': s.translation,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  // SURA LIST FOR DIFFERENT LANGUAGAE
  Future<List<AllSurahs>> getSurahList(String lang) async {
    final db = await QuranDb.instance;
    final rows = await db.rawQuery(
      '''
      SELECT s.id, s.name, s.transliteration, s.type, s.total_verses,
             st.translation
      FROM surahs s
      LEFT JOIN surah_translation st
        ON s.id = st.surah_id AND st.lang = ?
      ORDER BY s.id
    ''',
      [lang],
    );

    return rows.map((r) {
      return AllSurahs(
        id: r['id'] as int,
        name: r['name'] as String,
        transliteration: r['transliteration'] as String,
        translation: (r['translation'] as String?) ?? '',
        type: r['type'] as String,
        totalVerses: r['total_verses'] as int,
      );
    }).toList();
  }

  // SURA VERSES
  Future<void> upsertSurahDetail(String lang, SurahDetail detail) async {
    final db = await QuranDb.instance;
    await db.transaction((tx) async {
      await tx.insert('surahs', {
        'id': detail.id,
        'name': detail.name,
        'transliteration': detail.transliteration,
        'type': detail.type,
        'total_verses': detail.totalVerses,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);

      // Save per-language surah translation
      await tx.insert('surah_translation', {
        'surah_id': detail.id,
        'lang': lang,
        'translation': detail.translation,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      // Upsert verses & translations
      final batch = tx.batch();
      for (final Verse v in detail.verses) {
        batch.insert('verses', {
          'surah_id': detail.id,
          'verse_id': v.id,
          'arabic_text': v.arabic,
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
        batch.insert('verse_translations', {
          'surah_id': detail.id,
          'verse_id': v.id,
          'lang': lang,
          'translation': v.meaning,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    });
  }

  // SURAH WITH SELECTED LANGUAGE
  Future<SurahDetail?> getSurahDetail(int surahId, String lang) async {
    final db = await QuranDb.instance;
    
    final header = await db.rawQuery(
      '''
      SELECT s.id, s.name, s.transliteration, s.type, s.total_verses,
             st.translation
      FROM surahs s
      LEFT JOIN surah_translation st
        ON s.id = st.surah_id AND st.lang = ?
      WHERE s.id = ?
      LIMIT 1
    ''',
      [lang, surahId],
    );

    if (header.isEmpty) return null;
    final rows = await db.rawQuery(
      '''
      SELECT v.verse_id, v.arabic_text, vt.translation
      FROM verses v
      LEFT JOIN verse_translations vt
        ON v.surah_id = vt.surah_id AND v.verse_id = vt.verse_id AND vt.lang = ?
      WHERE v.surah_id = ?
      ORDER BY v.verse_id
    ''',
      [lang, surahId],
    );

    final verses = rows.map((r) {
      return Verse(
        id: r['verse_id'] as int,
        arabic: r['arabic_text'] as String,
        meaning: (r['translation'] as String?) ?? '',
      );
    }).toList();

    final h = header.first;
    return SurahDetail(
      id: h['id'] as int,
      name: h['name'] as String,
      transliteration: h['transliteration'] as String,
      translation: (h['translation'] as String?) ?? '',
      type: h['type'] as String,
      totalVerses: h['total_verses'] as int,
      audio: const {},
      verses: verses,
    );
  }
}
