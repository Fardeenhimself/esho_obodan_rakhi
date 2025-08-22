import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/services/auth/profile_repository.dart';
import 'package:islamic_app/models/auth_model/user_profile.dart';

final profileRepositoryProvider = Provider((ref) => ProfileRepository());

final profileProvider = FutureProvider<UserProfile>((ref) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.fetchProfile();
});
