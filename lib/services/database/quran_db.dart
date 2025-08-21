import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuranDb {
  static Database? _db;

  static Future<Database> get instance async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'quran.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // First for surahs
        await db.execute(''' CREATE TABLE surahs(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          transliteration TEXT NOT NULL,
          type TEXT NOT NULL,
          total_verses INTEGER NOT NULL
          ) ''');

        // Translation for each sura
        await db.execute(''' CREATE TABLE surah_translation(
          surah_id INTEGER NOT NULL,
          lang TEXT NOT NULL,
          translation TEXT NOT NULL,
          PRIMARY KEY(surah_id, lang)
          ) ''');

        // Arbi verse
        await db.execute('''
          CREATE TABLE verses(
            surah_id INTEGER NOT NULL,
            verse_id INTEGER NOT NULL,      
            arabic_text TEXT NOT NULL,
            PRIMARY KEY(surah_id, verse_id)
          )
        ''');

        // per language translation
        await db.execute('''
          CREATE TABLE verse_translations(
            surah_id INTEGER NOT NULL,
            verse_id INTEGER NOT NULL,
            lang TEXT NOT NULL,              
            translation TEXT NOT NULL,
            PRIMARY KEY(surah_id, verse_id, lang)
          )
        ''');

        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_surah_lang ON surah_translation(lang)',
        );
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_verse_lang ON verse_translations(lang)',
        );
      },
    );

    return _db!;
  }
}
