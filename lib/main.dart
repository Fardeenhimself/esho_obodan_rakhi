import 'package:flutter/material.dart';
//import 'package:islamic_app/screens/home_page.dart';
//import 'package:islamic_app/screens/login_screen.dart';
import 'package:islamic_app/screens/main_page.dart';
//import 'package:islamic_app/services/auth/login_or_register.dart';
import 'package:islamic_app/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const IslmaicApp()));
}

class IslmaicApp extends StatelessWidget {
  const IslmaicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: MainPage(),
    );
  }
}
