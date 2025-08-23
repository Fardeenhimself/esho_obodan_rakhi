import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/faq_provider.dart';

class FaqScreen extends ConsumerWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqAsync = ref.watch(faqProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("FAQs")),
      body: faqAsync.when(
        data: (faqs) {
          if (faqs.isEmpty) {
            return const Center(child: Text("No FAQs available."));
          }
          return ListView.builder(
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              final faq = faqs[index];
              return ExpansionTile(
                title: Text(faq.question),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(faq.answer),
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
