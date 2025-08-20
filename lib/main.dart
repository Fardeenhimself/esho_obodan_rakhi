import 'package:flutter/material.dart';
import 'package:islamic_app/screens/main_page.dart';
import 'package:islamic_app/theme/app_theme.dart';

void main() {
  runApp(const IslmaicApp());
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
