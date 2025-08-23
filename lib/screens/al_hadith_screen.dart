import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/hadith_category_provider.dart';
import 'package:islamic_app/screens/al_hadith_subcategory_screen.dart';

class AlHadithScreen extends ConsumerWidget {
  const AlHadithScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(hadithCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Hadith Categories')),
      body: categoriesAsync.when(
        data: (categories) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            AlHadithSubcategoryScreen(category: category),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primaryContainer
                          .withAlpha((0.5 * 255).round()),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.menu_book_rounded),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              category.title,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
