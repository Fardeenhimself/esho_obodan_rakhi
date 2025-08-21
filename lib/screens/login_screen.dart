import 'package:flutter/material.dart';
import 'package:islamic_app/components/my_auth_text_field.dart';

import '../components/my_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final void Function()? onTap;

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
              'এসো অবদান রাখি!',
              style: TextStyle(
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
            MyButton(text: 'লগইন', onTap: () {}),
            const SizedBox(height: 20),
            // Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('এ্যাকাউন্ট নেই?', style: TextStyle(color: Colors.white)),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'রেজিস্ট্রেশন করুন',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
