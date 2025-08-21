import 'package:flutter/material.dart';
//import 'package:islamic_app/screens/home_page.dart';
//import 'package:islamic_app/screens/login_screen.dart';
import 'package:islamic_app/screens/main_page.dart';
import 'package:islamic_app/services/auth/login_or_register.dart';
//import 'package:islamic_app/services/auth/login_or_register.dart';
import 'package:islamic_app/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZteGttaHZvd3l0dXlja2twZGlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU3OTQwMzYsImV4cCI6MjA3MTM3MDAzNn0.jieeKdXQSU3EJX9P93MkH7q38nOCqlFbmzA2GRLf1ec',
    url: 'https://fmxkmhvowytuyckkpdil.supabase.co',
  );
  runApp(ProviderScope(child: const IslmaicApp()));
}

class IslmaicApp extends StatelessWidget {
  const IslmaicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: LoginOrRegister(),
    );
  }
}
