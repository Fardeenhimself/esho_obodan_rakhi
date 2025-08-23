import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/core_models/hadith_category.dart';
import 'package:islamic_app/providers/hadith_category_provider.dart';
import 'package:islamic_app/screens/single_hadith_screen.dart';

class AlHadithSubcategoryScreen extends ConsumerWidget {
  final HadithCategory category;

  const AlHadithSubcategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategoryAsync = ref.watch(hadithSubCategoryProvider(category.id));

    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: subCategoryAsync.when(
        data: (hadiths) {
          return ListView.builder(
            itemCount: hadiths.length,
            itemBuilder: (context, index) {
              final subCat = hadiths[index];
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
                            SingleHadithScreen(hadithId: subCat.id),
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
                          Icon(Icons.info),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              subCat.title,
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
        loading: () => const Center(child: CupertinoActivityIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
