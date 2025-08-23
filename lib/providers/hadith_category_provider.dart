import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/core_models/hadith_category.dart';
import 'package:islamic_app/models/core_models/hadith_subcategory.dart';
import 'package:islamic_app/models/core_models/single_hadith.dart';
import 'package:islamic_app/services/core/hadith_repository.dart';

// Main hadith repo
final hadithRepositoryProvider = Provider<HadithRepository>((ref) {
  return HadithRepository();
});

// Categories
final hadithCategoriesProvider = FutureProvider<List<HadithCategory>>((
  ref,
) async {
  final repo = ref.read(hadithRepositoryProvider);
  return repo.fetchCategories();
});

// Sub-Categories
final hadithSubCategoryProvider =
    FutureProvider.family<List<HadithSubcategory>, String>((
      ref,
      categoryId,
    ) async {
      final repo = ref.read(hadithRepositoryProvider);
      return repo.fetchHadithSubCategory(categoryId: categoryId);
    });

// Signle hadith
final singleHadithProvider = FutureProvider.family<SingleHadith, String>((
  ref,
  id,
) async {
  final repo = ref.read(hadithRepositoryProvider);
  return repo.fetchSingleHadith(id: id);
});
