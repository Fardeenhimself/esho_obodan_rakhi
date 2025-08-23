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

    return Scaffold(
      appBar: AppBar(title: const Text(' হাদিস ব্যাখ্যা')),
      body: singleHadithAsync.when(
        data: (hadith) {
          return ListView(
            children: [
              Text(
                hadith.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(hadith.hadeeth, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Attribution: ${hadith.attribution}'),
              Text('Grade: ${hadith.grade}'),
              const SizedBox(height: 10),
              Text(
                'Explanation:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(hadith.explanation),
              const SizedBox(height: 10),
            ],
          );
        },
        loading: () => Center(child: CupertinoActivityIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
