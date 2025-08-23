import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/hadith_category_provider.dart';

class InfoScreen extends ConsumerWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(hadithFontSizeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'মুহতারাম/মুহতারমা,',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'আসসালামু আলাইকুম ওয়া রহমাতুল্লাহ',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'বর্তমান যুগ ফেতনার যুগ। মিডিয়া বা প্রযুক্তির অপব্যবহার বেড়েই চলেছে। দ্বীনের পোশাক পরিধান করে বহুজন বদদ্বীনি কাজে লিপ্ত। সকল দিকে লক্ষ্য রেখে মিডিয়ার বা প্রযুক্তির সহীহ ব্যবহারের ফল আমাদের এ্যাপ্স। উলামায়ে কেরাম এর চিন্তা চেতনা "গুনাহ থেকে বাঁচা"। আমাদের এই এ্যাপ্স একই ধারণায় তৈরি। তাই কোন প্রকার বিজ্ঞাপন ছাড়া বিনামূল্যে সকলের খেদমতে আমাদের এই এ্যাপ।',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'আমাদের এই এ্যাপ্সটি যদি আপনাদের কাছে ভালো লেগে থাকে তবে আমাদের কে আপনাদের দোওায় রাখিবেন। সাথে আপনাদের কাছে নিকট দুয়া ও সহযোগীতার আবেদন।,',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'সহযোগীতার নিয়মঃ',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'বিকাশ/নগদ',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'ফারদ্বীন: 01711379218',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'মাজহারুল: 01797192725',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'বি.দ্র. যাকাত, ফিতরার টাকা এখানে প্রদান করা যাবে না। তাহলে যাকাত আদায় হবে না। ',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'মহান আল্লাহ আপনাদের উত্তম জাযাহ দান করুক। বারাক আল্লাহু ফিকুম',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Divider(indent: 50, endIndent: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
