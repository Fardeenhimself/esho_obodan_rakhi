import 'package:flutter/material.dart';
import 'package:islamic_app/services/auth/auth_gate.dart';
import 'package:islamic_app/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(ProviderScope(child: const IslmaicApp()));
}

class IslmaicApp extends StatelessWidget {
  const IslmaicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: AuthGate(),
    );
  }
}
