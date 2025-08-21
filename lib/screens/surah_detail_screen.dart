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
      appBar: AppBar(title: Text(heading.toUpperCase())),
      body: detailAsync.when(
        data: (SurahDetail d) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          itemCount: d.verses.length,
          itemBuilder: (context, i) {
            final v = d.verses[i];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Verses number
                        Text(
                          '${v.id}',
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(width: 8),
                        // Arabic verse
                        Expanded(
                          child: Text(
                            v.arabic,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Translation verse
                    Text(
                      v.meaning,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        height: 1.4,
                      ),
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
