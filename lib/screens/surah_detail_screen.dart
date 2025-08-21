import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/surah_detail.dart';
import 'package:islamic_app/providers/quran_provider.dart';

class SurahDetailPage extends ConsumerWidget {
  final int surahId;
  final String heading;

  const SurahDetailPage({
    super.key,
    required this.surahId,
    required this.heading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(surahDetailProvider(surahId));

    return Scaffold(
      appBar: AppBar(title: Text(heading)),
      body: detailAsync.when(
        data: (SurahDetail d) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          itemCount: d.verses.length,
          itemBuilder: (context, i) {
            final v = d.verses[i];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Arabic
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${v.id}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            v.arabic,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              // fontFamily: 'Amiri', // if you add an Arabic font
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Translation (bn/en)
                    Text(
                      v.meaning,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
