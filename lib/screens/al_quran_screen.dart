import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/sura.dart';
import 'package:islamic_app/providers/quran_provider.dart';
import 'package:islamic_app/screens/surah_detail_screen.dart';

class AlQuranScreen extends ConsumerWidget {
  const AlQuranScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quranAsync = ref.watch(quranProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Al-Quran")),
      body: quranAsync.when(
        data: (surahs) {
          return ListView.builder(
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              final Surah surah = surahs[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    title: Text("${surah.number}. ${surah.englishName}"),
                    subtitle: Text(
                      "${surah.englishNameTranslation} | ${surah.revelationType}",
                    ),
                    trailing: Text(
                      surah.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SurahDetailsScreen(surah: surah),
                        ),
                      );
                    },
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
