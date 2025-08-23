import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/services/auth/profile_repository.dart';
import 'package:islamic_app/models/auth_model/user_profile.dart';

final profileRepositoryProvider = Provider((ref) => ProfileRepository());

final profileProvider = FutureProvider<UserProfile>((ref) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.fetchProfile();
});

class ProfileEditState {
  final bool isLoading;
  final String? error;
  final UserProfile? profile;

  ProfileEditState({this.isLoading = false, this.error, this.profile});

  ProfileEditState copyWith({
    bool? isLoading,
    String? error,
    UserProfile? profile,
  }) {
    return ProfileEditState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      profile: profile ?? this.profile,
    );
  }
}

class ProfileEditNotifier extends StateNotifier<ProfileEditState> {
  final ProfileRepository _repo;
  final Ref _ref;

  ProfileEditNotifier(this._repo, this._ref) : super(ProfileEditState());

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updatedProfile = await _repo.updateProfile(
        name: name,
        phone: phone,
      );

      // Update state
      state = state.copyWith(isLoading: false, profile: updatedProfile);

      // refresh to update ui asap
      await _ref.refresh(profileProvider.future);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final profileEditProvider =
    StateNotifierProvider<ProfileEditNotifier, ProfileEditState>(
      (ref) => ProfileEditNotifier(ref.read(profileRepositoryProvider), ref),
    );
