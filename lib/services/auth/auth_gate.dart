import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/screens/main_page.dart';
import 'package:islamic_app/services/auth/login_or_register.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(loginProvider);

    if (!authState.isLoggedIn) {
      return LoginOrRegister();
    } else {
      return const MainPage();
    }
  }
}
