import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/auth_model/signup_response.dart';
import 'package:islamic_app/services/auth/signup_repository.dart';

final signupRepositoryProvider = Provider<SignupRepository>((ref) {
  return SignupRepository();
});

final signupProvider =
    FutureProvider.family<SignupResponse, Map<String, String>>((
      ref,
      data,
    ) async {
      final repo = ref.watch(signupRepositoryProvider);
      return repo.signup(
        name: data['name']!,
        email: data['email']!,
        phone: data['phone']!,
        pin: data['pin']!,
        pinConfirmation: data['pin_confirmation']!,
      );
    });
