import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/core_models/faq.dart';
import 'package:islamic_app/services/core/faq_repository.dart';

final faqRepositoryProvider = Provider<FaqRepository>((ref) => FaqRepository());

final faqProvider = FutureProvider<List<Faq>>((ref) async {
  final repo = ref.watch(faqRepositoryProvider);
  return repo.fetchFaqs();
});
