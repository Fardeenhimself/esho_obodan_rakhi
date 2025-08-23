import 'package:flutter/material.dart';
import 'package:islamic_app/providers/theme_provider.dart';
import 'package:islamic_app/services/auth/auth_gate.dart';
import 'package:islamic_app/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const IslmaicApp()));
}

class IslmaicApp extends ConsumerWidget {
  const IslmaicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: AuthGate(),
    );
  }
}
