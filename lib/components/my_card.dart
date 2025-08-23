import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/hadith_category_provider.dart';

class MyCard extends ConsumerWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hadithAsync = ref.watch(randomHadithProvider);

    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: hadithAsync.when(
          data: (hadith) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                hadith.description,
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) =>
              Center(child: Text('আপনার ইন্টারনেট সেবা চালু করুন')),
        ),
      ),
    );
  }
}
