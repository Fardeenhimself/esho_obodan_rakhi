import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/my_auth_text_field.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/providers/profilerepository_provider.dart';
import '../components/my_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({super.key, this.onTap});

  final void Function()? onTap;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // login function
  void login(BuildContext context) async {
    final email = _emailController.text.trim();
    final pin = _passwordController.text.trim();

    if (email.isEmpty || pin.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("সব ফিল্ড পূরণ করুন")));
      return;
    }

    try {
      // call login through authProvider
      await ref.read(loginProvider.notifier).login(email, pin);
      ref.refresh(profileProvider);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("লগইন সফল!")));
    } catch (e) {
      debugPrint('error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("লগইন ব্যর্থ: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(Icons.mosque, size: 50, color: Colors.white),
            const SizedBox(height: 12),
            // Some Text
            Text(
              'দাওয়াহ',
              style: TextStyle(
                fontFamily: 'bangla',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Email
            MyAuthTextField(
              hintText: 'ইমেইল',
              obscureText: false,
              prefixIcon: Icon(Icons.email),
              controller: _emailController,
              keyboardType: TextInputType.text,
            ),
            // Password
            MyAuthTextField(
              hintText: 'আপনার পিন নাম্বর',
              obscureText: true,
              prefixIcon: Icon(Icons.password_rounded),
              controller: _passwordController,
              keyboardType: TextInputType.number,
            ),
            // Login Button
            MyButton(text: 'লগইন', onTap: () => login(context)),
            const SizedBox(height: 20),
            // Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'এ্যাকাউন্ট নেই?',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'রেজিস্ট্রেশন করুন',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'bangla',
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
