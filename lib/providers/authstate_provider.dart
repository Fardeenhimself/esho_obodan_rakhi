import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/services/auth/login_repository.dart';

class AuthState {
  final bool isLoggedIn;
  final String? role;

  AuthState({required this.isLoggedIn, this.role});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginRepository _repo;

  AuthNotifier(this._repo) : super(AuthState(isLoggedIn: false)) {
    _loadAuth();
  }

  Future<void> _loadAuth() async {
    final token = await _repo.getToken();
    final role = await _repo.getRole();
    state = AuthState(isLoggedIn: token != null, role: role);
  }

  Future<void> login(String email, String pin) async {
    final res = await _repo.login(email: email, pin: pin);
    state = AuthState(isLoggedIn: true, role: res.user.role);
  }

  Future<void> logout() async {
    await _repo.logout();
    state = AuthState(isLoggedIn: false);
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repo = ref.watch(loginRepositoryProvider);
  return AuthNotifier(repo);
});
