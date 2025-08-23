import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/donation_provider.dart';
import 'package:islamic_app/providers/profilerepository_provider.dart';
import 'package:islamic_app/services/auth/login_repository.dart';
import 'package:islamic_app/services/auth/logout_repository.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class LoginState {
  final bool isLoggedIn;
  final String? role;

  LoginState({required this.isLoggedIn, this.role});
}

// logout provider
final logoutRepositoryProvider = Provider<LogoutRepository>(
  (ref) => LogoutRepository(),
);

// login
class LoginNotifier extends StateNotifier<LoginState> {
  final LoginRepository _repo;
  final LogoutRepository _logoutRepo;
  final Ref _ref;

  LoginNotifier(this._repo, this._logoutRepo, this._ref)
    : super(LoginState(isLoggedIn: false)) {
    _loadAuth();
  }

  Future<void> _loadAuth() async {
    final token = await _repo.getToken();
    final role = await _repo.getRole();
    state = LoginState(isLoggedIn: token != null, role: role);
  }

  Future<void> login(String email, String pin) async {
    final res = await _repo.login(email: email, pin: pin);
    state = LoginState(isLoggedIn: true, role: res.user.role);
    print('LoginProvider: isLoggedIn=${state.isLoggedIn}, role=${state.role}');

    // fetch profile for new user
    _ref.refresh(profileProvider);

    // invalidate so new donation is fetched
    _ref.invalidate(userDonationProvider);
  }

  Future<void> logout() async {
    await _logoutRepo.logOut();

    // resets the login state
    state = LoginState(isLoggedIn: false);

    // invalidate the provider and donation provider so that user data is cleared...
    _ref.invalidate(profileProvider);
    _ref.invalidate(userDonationProvider);
  }

  Future<void> clearLocalToken() async {
    // Delete stored credentials
    await SecureStorageService.delete('auth_token');
    await SecureStorageService.delete('user_role');
    await SecureStorageService.delete('user_email');
    await SecureStorageService.delete('user_id');

    // Update login state
    state = LoginState(isLoggedIn: false);
  }
}

// Login repo provider
final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(),
);

// login provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(
    ref.watch(loginRepositoryProvider),
    ref.watch(logoutRepositoryProvider),
    ref,
  ),
);
