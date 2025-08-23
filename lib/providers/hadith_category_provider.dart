import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/core_models/hadith_category.dart';
import 'package:islamic_app/services/core/hadith_repository.dart';

final hadithRepositoryProvider = Provider<HadithRepository>((ref) {
  return HadithRepository();
});

final hadithCategoriesProvider = FutureProvider<List<HadithCategory>>((
  ref,
) async {
  final repo = ref.read(hadithRepositoryProvider);
  return repo.fetchCategories();
});
