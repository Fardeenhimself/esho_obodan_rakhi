import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/services/auth/login_repository.dart';

class LoginState {
  final bool isLoggedIn;
  final String? role;

  LoginState({required this.isLoggedIn, this.role});
}

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginRepository _repo;

  LoginNotifier(this._repo) : super(LoginState(isLoggedIn: false)) {
    _loadAuth();
  }

  Future<void> _loadAuth() async {
    final token = await _repo.getToken();
    final role = await _repo.getRole();
    // final name = await _repo.getUserName();
    // final email = await _repo.getUserEmail();
    state = LoginState(isLoggedIn: token != null, role: role);
  }

  Future<void> login(String email, String pin) async {
    final res = await _repo.login(email: email, pin: pin);
    state = LoginState(isLoggedIn: true, role: res.user.role);
  }

  Future<void> logout() async {
    await _repo.logout();
    state = LoginState(isLoggedIn: false);
  }
}

// Login repo provider
final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(),
);

// login provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(ref.watch(loginRepositoryProvider)),
);
