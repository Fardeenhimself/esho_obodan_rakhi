import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/faq_provider.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/screens/faq_details_screen.dart';

class FaqScreen extends ConsumerWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqAsync = ref.watch(faqProvider);
    final user = ref.watch(loginProvider);

    // add faq function
    void _showAddFaqDialog(BuildContext context, WidgetRef ref) {
      final _questionController = TextEditingController();
      final _answerController = TextEditingController();

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'নতুন প্রশ্ন যোগ করুন',
            style: TextStyle(fontFamily: 'bangla'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'প্রশ্ন',
                  labelStyle: TextStyle(fontFamily: 'bangla', fontSize: 16),
                ),
                style: TextStyle(fontFamily: 'bangla', fontSize: 16),
              ),
              TextField(
                controller: _answerController,
                decoration: InputDecoration(
                  labelText: 'উত্তর',
                  labelStyle: TextStyle(fontFamily: 'bangla', fontSize: 16),
                ),
                style: TextStyle(fontFamily: 'bangla', fontSize: 16),
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'বাদ দিন',
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final question = _questionController.text.trim();
                final answer = _answerController.text.trim();

                if (question.isEmpty || answer.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('প্রশ্ন এবং উত্তর ফাঁকা থাকতে পারবে না!'),
                    ),
                  );
                  return;
                }

                try {
                  await ref
                      .read(faqRepositoryProvider)
                      .addFaq(question: question, answer: answer);

                  ref.invalidate(faqProvider);
                  Navigator.pop(ctx);

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('FAQ যোগ করা হয়েছে')));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('যোগ করা সফল হয়নি!')));
                }
              },
              child: Text(
                'যোগ করুন',
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
        title: const Text(
          "প্রশ্ন উত্তর",
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: faqAsync.when(
        data: (faqs) {
          if (faqs.isEmpty) {
            return const Center(child: Text("প্রশ্ন নেই"));
          }
          return ListView.builder(
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              final faq = faqs[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => FaqDetailsScreen(faqId: faq.id),
                      ),
                    );
                  },
                  splashColor: Theme.of(
                    context,
                  ).colorScheme.tertiary.withAlpha(76),
                  borderRadius: BorderRadius.circular(12),
                  child: ListTile(
                    leading: Icon(Icons.question_mark),
                    title: Text(
                      faq.question,
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),

      floatingActionButton: user.role == "admin"
          ? FloatingActionButton.extended(
              onPressed: () => _showAddFaqDialog(context, ref),
              icon: Icon(Icons.add),
              label: Text(
                'প্রশ্ন যোগ করুন',
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
