import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/filter_drawer.dart';
import 'package:islamic_app/models/sura.dart';
import 'package:islamic_app/providers/quran_provider.dart';
import 'package:islamic_app/screens/surah_detail_screen.dart';

class AlQuranScreen extends ConsumerWidget {
  const AlQuranScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsAsync = ref.watch(surahListProvider);
    final lang = ref.watch(translationLangProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Al Quran (${lang.label})')),
      endDrawer: const FilterDrawer(),
      body: surahsAsync.when(
        data: (surahs) => ListView.separated(
          itemCount: surahs.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) {
            final AllSurahs s = surahs[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Text('${s.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.transliteration, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(s.translation, style: const TextStyle(fontSize: 14)),
                  Text(s.type[0].toUpperCase() + s.type.substring(1)),
                ],
              ),
              trailing: Text(
                s.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SurahDetailPage(
                      surahId: s.id,
                      heading: s.transliteration,
                    ),
                  ),
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
