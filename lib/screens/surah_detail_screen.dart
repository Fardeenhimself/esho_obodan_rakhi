import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/sura.dart';
import 'package:islamic_app/providers/quran_provider.dart';

class SurahDetailsScreen extends ConsumerWidget {
  final Surah surah;

  const SurahDetailsScreen({super.key, required this.surah});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ayahsAsync = ref.watch(surahAyahsProvider(surah.number));

    return Scaffold(
      appBar: AppBar(title: Text(surah.englishName)),
      body: ayahsAsync.when(
        data: (ayahs) {
          return ListView.builder(
            itemCount: ayahs.length,
            itemBuilder: (context, index) {
              final ayah = ayahs[index];
              return ListTile(
                leading: CircleAvatar(child: Text("${ayah.numberInSurah}")),
                title: Text(ayah.text, textAlign: TextAlign.justify),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
