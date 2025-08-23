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
              return ListTile(
                title: Text(subCat.title),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => SingleHadithScreen(hadithId: subCat.id),
                    ),
                  );
                },
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
