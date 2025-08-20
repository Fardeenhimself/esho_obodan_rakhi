
import 'package:flutter/material.dart';
import 'package:islamic_app/components/my_auth_text_field.dart';
import 'package:islamic_app/components/my_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key, required this.onTap});

  final void Function()? onTap;

  // Controllers for text and password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPWController = TextEditingController();

  // Helper method to validate email domain
  bool isValidEmailDomain(String email) {
    final allowedDomains = [
      'gmail.com',
      'outlook.com',
      'yahoo.com',
      'icloud.com',
      'hotmail.com',
      'live.com',
      'aol.com',
    ];

    try {
      final domain = email.split('@').last.toLowerCase();
      return allowedDomains.contains(domain);
    } catch (e) {
      return false;
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
            Icon(
              Icons.mosque,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            // Some Text
            Text(
              'এ্যাকাউন্ট তৈরি করুন',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Username
            MyAuthTextField(
              hintText: 'নাম',
              obscureText: false,
              prefixIcon: Icon(Icons.person),
              controller: _usernameController,
              keyboardType: TextInputType.text,
            ),
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
              hintText: '৪ ডিজিটের পিন লিখুন',
              obscureText: true,
              prefixIcon: Icon(Icons.password_rounded),
              controller: _passwordController,
              keyboardType: TextInputType.number,
            ),

            // Confirm Password
            MyAuthTextField(
              hintText: 'পুনরায় পিন লিখুন',
              obscureText: true,
              prefixIcon: Icon(Icons.password_rounded),
              controller: _confirmPWController,
              keyboardType: TextInputType.number,
            ),
            // Login Button
            MyButton(text: 'রেজিস্টার', onTap: (){}),
            const SizedBox(height: 20),
            // Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'এ্যাকাউন্ট আছে?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'লগইন করুন',
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