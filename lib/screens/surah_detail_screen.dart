import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/sura.dart';
import 'package:islamic_app/providers/quran_provider.dart';

class SurahDetailsScreen extends ConsumerWidget {
  final Surah surah;

  const SurahDetailsScreen({super.key, required this.surah});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ayahsAsync = ref.watch(quranProvider);

    return Scaffold(
      appBar: AppBar(title: Text(surah.englishName)),
      body: ayahsAsync.when(
        data: (ayahs) {
          return ListView.builder(
            itemCount: surah.ayahs.length,
            itemBuilder: (context, index) {
              final ayah = surah.ayahs[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('${ayah.numberInSurah}.'),
                      Text(
                        ayah.arabicText,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Amiri",
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ayah.banglaText,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Page: ${ayah.page}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
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
