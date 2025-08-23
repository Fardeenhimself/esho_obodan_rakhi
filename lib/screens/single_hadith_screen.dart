import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/hadith_category_provider.dart';

class SingleHadithScreen extends ConsumerWidget {
  const SingleHadithScreen({super.key, required this.hadithId});

  final String hadithId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singleHadithAsync = ref.watch(singleHadithProvider(hadithId));
    final fontSize = ref.watch(hadithFontSizeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' হাদিস ব্যাখ্যা',
          style: TextStyle(fontFamily: 'bangla', fontSize: 24),
        ),
        actions: [
          // decrease font
          IconButton(
            onPressed: () {
              ref.read(hadithFontSizeProvider.notifier).state = (fontSize > 10)
                  ? fontSize - 1
                  : fontSize;
            },
            icon: Icon(Icons.text_decrease),
          ),

          // decrease font
          IconButton(
            onPressed: () {
              ref.read(hadithFontSizeProvider.notifier).state = (fontSize < 50)
                  ? fontSize + 1
                  : fontSize;
            },
            icon: Icon(Icons.text_increase),
          ),
        ],
      ),
      body: singleHadithAsync.when(
        data: (hadith) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                Text(
                  hadith.title,
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  hadith.hadeeth,
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: fontSize.toDouble(),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'রেফারেন্সঃ ${hadith.attribution}',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'গ্রেডঃ ${hadith.grade}',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'ব্যাখ্যাঃ',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  hadith.explanation,
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: fontSize.toDouble(),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
        loading: () => Center(child: CupertinoActivityIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
