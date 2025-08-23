import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/services/core/donation_category_repository.dart';
import 'package:islamic_app/models/core_models/donation_category.dart';

final donationCategoryRepositoryProvider = Provider(
  (ref) => DonationCategoryRepository(),
);

final donationCategoryProvider = FutureProvider<List<DonationCategory>>((
  ref,
) async {
  final repo = ref.read(donationCategoryRepositoryProvider);
  return repo.fetchCategories();
});
