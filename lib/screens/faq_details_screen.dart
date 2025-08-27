import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/faq_provider.dart';
import 'package:islamic_app/providers/hadith_category_provider.dart';
import 'package:islamic_app/providers/login_provider.dart';

class FaqDetailsScreen extends ConsumerWidget {
  const FaqDetailsScreen({super.key, required this.faqId});

  final String faqId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqAsync = ref.watch(faqDetailProvider(faqId));
    final fontSize = ref.watch(hadithFontSizeProvider);
    final user = ref.watch(loginProvider);

    // delete function
    void _showDeleteFaqDialog(
      BuildContext context,
      WidgetRef ref,
      String faqId,
    ) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'নিশ্চিত করুন',
            style: TextStyle(
              fontFamily: 'bangla',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'আপনি কি এই প্রশ্নটি মুছে ফেলতে চান?',
            style: TextStyle(
              fontFamily: 'bangla',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(
                'না',
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(faqRepositoryProvider).deleteFaq(faqId);
                  ref.invalidate(faqProvider);
                  Navigator.pop(ctx);
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('FAQ সফলভাবে ডিলিট হয়েছে')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('ডিলিট সম্ভব হয়নি: $e')),
                  );
                }
              },
              child: const Text(
                'হ্যাঁ',
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'উত্তর',
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: user.role == "admin"
            ? [
                // decrease font
                IconButton(
                  onPressed: () {
                    ref.read(hadithFontSizeProvider.notifier).state =
                        (fontSize > 10) ? fontSize - 1 : fontSize;
                  },
                  icon: Icon(Icons.text_decrease),
                ),

                // decrease font
                IconButton(
                  onPressed: () {
                    ref.read(hadithFontSizeProvider.notifier).state =
                        (fontSize < 50) ? fontSize + 1 : fontSize;
                  },
                  icon: Icon(Icons.text_increase),
                ),
                // if admin, can delete
                IconButton(
                  onPressed: () => _showDeleteFaqDialog(context, ref, faqId),
                  icon: Icon(Icons.delete_forever, size: 30),
                ),
              ]
            : [
                // decrease font
                IconButton(
                  onPressed: () {
                    ref.read(hadithFontSizeProvider.notifier).state =
                        (fontSize > 10) ? fontSize - 1 : fontSize;
                  },
                  icon: Icon(Icons.text_decrease),
                ),

                // decrease font
                IconButton(
                  onPressed: () {
                    ref.read(hadithFontSizeProvider.notifier).state =
                        (fontSize < 50) ? fontSize + 1 : fontSize;
                  },
                  icon: Icon(Icons.text_increase),
                ),
              ],
      ),
      body: faqAsync.when(
        loading: () => Center(child: CupertinoActivityIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (singleFaq) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withAlpha(76),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'প্রশ্নঃ ${singleFaq.question}',
                        style: TextStyle(
                          fontFamily: 'bangla',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'উত্তরঃ ${singleFaq.answer}',
                        style: TextStyle(
                          fontFamily: 'bangla',
                          fontSize: fontSize.toDouble(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
