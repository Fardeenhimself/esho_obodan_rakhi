import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/auth_model/all_user.dart';
import 'package:islamic_app/services/core/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(),
);

final allUsersProvider = FutureProvider<List<AllUser>>((ref) async {
  final repo = ref.watch(userRepositoryProvider);
  return repo.fetchAllUsers();
});

// ban user
class UserActionState {
  final bool isLoading;
  final String? error;
  final bool success;

  UserActionState({this.isLoading = false, this.error, this.success = false});

  UserActionState copyWith({bool? isLoading, String? error, bool? success}) {
    return UserActionState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class UserActionNotifier extends StateNotifier<UserActionState> {
  final UserRepository _repo;
  final Ref _ref;
  UserActionNotifier(this._repo, this._ref) : super(UserActionState());

  // ban user
  Future<void> banUser(String userId, bool isBanned) async {
    state = state.copyWith(isLoading: true, error: null, success: false);

    try {
      await _repo.banUser(userId, isBanned);
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // make admin
  Future<void> updateRole(String userId, String role) async {
    // Determine new role (first we did this inside our repo, now we do here)
    final newRole = role == 'user' ? 'admin' : 'user';
    state = state.copyWith(isLoading: true, error: null, success: false);

    try {
      await _repo.updateUserRole(userId, newRole);
      state = state.copyWith(isLoading: false, success: true);
      // Refresh all users after action
      _ref.invalidate(allUsersProvider);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = UserActionState();
  }
}

final userActionProvider =
    StateNotifierProvider<UserActionNotifier, UserActionState>(
      (ref) => UserActionNotifier(ref.read(userRepositoryProvider), ref),
    );
