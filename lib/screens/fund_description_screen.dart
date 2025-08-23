import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/hadith_category_provider.dart';

class FundDescriptionScreen extends ConsumerWidget {
  const FundDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(hadithFontSizeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'এসো অবদান রাখি',
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
                      'আসসালামু আলাইকুম ওয়া রহমাতুল্লাহ,',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'আমাদের ইসলামিক ফান্ড একটি মানবিক ও সমাজসেবামূলক উদ্যোগ, যার মূল লক্ষ্য হলো বিপদগ্রস্ত, অসহায় এবং সুবিধাবঞ্চিত মানুষদের পাশে দাঁড়ানো—ধর্ম, জাতি বা পরিচয় নির্বিশেষে। আমরা বিশ্বাস করি, মানবতা সব ধর্মের ঊর্ধ্বে, এবং সাহায্য পাওয়ার অধিকার সবার আছে।',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'এই ফান্ডের মাধ্যমে আমরা বিভিন্ন ধরনের সহায়তা প্রদান করি, যেমন:',
                      style: TextStyle(
                        fontFamily: 'bangla',

                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.bloodtype_sharp),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'রক্তের ব্যবস্থা: জরুরি অবস্থায় রোগীদের জন্য রক্ত সংগ্রহ ও সরবরাহে সহায়তা।',
                            style: TextStyle(
                              fontFamily: 'bangla',

                              fontSize: fontSize.toDouble(),
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.dining_rounded),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'খাদ্য সহায়তা: দরিদ্র পরিবার, পথশিশু ও দুর্যোগপীড়িতদের জন্য খাবার বিতরণ।',
                            style: TextStyle(
                              fontFamily: 'bangla',

                              fontSize: fontSize.toDouble(),
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.monetization_on),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            ' আর্থিক সহায়তা: চিকিৎসা, শিক্ষা, বাসস্থান বা দৈনন্দিন জীবনের জরুরি চাহিদা পূরণে অর্থ সহায়তা।',
                            style: TextStyle(
                              fontFamily: 'bangla',

                              fontSize: fontSize.toDouble(),
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.shopping_bag_rounded),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            ' প্রয়োজনীয় সামগ্রী: শীতবস্ত্র, ওষুধ, স্কুল সামগ্রী ইত্যাদি বিতরণ',
                            style: TextStyle(
                              fontFamily: 'bangla',

                              fontSize: fontSize.toDouble(),
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'আমাদের কার্যক্রম পরিচালিত হয় সম্পূর্ণ স্বচ্ছতা ও জবাবদিহিতার ভিত্তিতে। প্রতিটি অনুদান সঠিকভাবে ব্যবহার হয় এবং আমরা নিয়মিত রিপোর্ট ও আপডেট প্রদান করি যাতে দাতারা জানেন তাদের সহায়তা কোথায় যাচ্ছে।',
                      style: TextStyle(
                        fontFamily: 'bangla',

                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'এই ফান্ডের মাধ্যমে আমরা শুধু সাহায্য নয়, একটি ভালোবাসার বন্ধন গড়ে তুলতে চাই—যেখানে মানুষ মানুষের পাশে দাঁড়ায়, একে অপরের দুঃখ-কষ্ট ভাগ করে নেয়। আপনার অংশগ্রহণ আমাদের এই পথচলাকে আরও শক্তিশালী করে তুলবে।',
                      style: TextStyle(
                        fontFamily: 'bangla',

                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
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
                    const SizedBox(height: 20),
                    const Divider(indent: 50, endIndent: 50),
                    const SizedBox(height: 12),
                    Text(
                      'আমাদের কয়েকজন মেম্বর',
                      style: TextStyle(
                        fontFamily: 'bangla',

                        fontSize: fontSize.toDouble(),
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primaryContainer
                            .withAlpha((0.2 * 255).round()),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              'রহমত ভাই',
                              style: TextStyle(
                                fontFamily: 'bangla',
                                fontSize: 18,
                              ),
                            ),
                            trailing: Icon(Icons.call),
                          ),
                          ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              'আরিফ ভাই',
                              style: TextStyle(
                                fontFamily: 'bangla',
                                fontSize: 18,
                              ),
                            ),
                            trailing: Icon(Icons.call),
                          ),
                          ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              'তামজিদ ভাই',
                              style: TextStyle(
                                fontFamily: 'bangla',
                                fontSize: 18,
                              ),
                            ),
                            trailing: Icon(Icons.call),
                          ),
                          ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              'ফারদ্বীন ভাই',
                              style: TextStyle(
                                fontFamily: 'bangla',
                                fontSize: 18,
                              ),
                            ),
                            trailing: Icon(Icons.call),
                          ),
                          ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              'মাজহারুল ভাই',
                              style: TextStyle(
                                fontFamily: 'bangla',
                                fontSize: 18,
                              ),
                            ),
                            trailing: Icon(Icons.call),
                          ),
                          ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              'ইফতি ভাই',
                              style: TextStyle(
                                fontFamily: 'bangla',
                                fontSize: 18,
                              ),
                            ),
                            trailing: Icon(Icons.call),
                          ),
                        ],
                      ),
                    ),
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
