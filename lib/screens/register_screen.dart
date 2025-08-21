import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/my_auth_text_field.dart';
import 'package:islamic_app/components/my_button.dart';
import 'package:islamic_app/providers/signup_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  RegisterScreen({super.key, required this.onTap});

  final void Function()? onTap;
  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  // Controllers for text and password
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPWController = TextEditingController();
  bool isLoading = false;

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
            Icon(Icons.mosque, size: 50, color: Colors.white),
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
              controller: _nameController,
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
            //Phone
            MyAuthTextField(
              hintText: 'ফোন নাম্বর',
              obscureText: false,
              prefixIcon: Icon(Icons.smartphone),
              controller: _phoneController,
              keyboardType: TextInputType.number,
              maxLength: 11,
            ),
            // Password
            MyAuthTextField(
              hintText: 'পিন লিখুন',
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
            isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : MyButton(
                    text: 'রেজিস্টার',
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final signupFuture = ref.refresh(
                        signupProvider({
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "phone": _phoneController.text,
                          "pin": _passwordController.text,
                          "pin_confirmation": _confirmPWController.text,
                        }).future,
                      );
                      signupFuture
                          .then((res) {
                            print('successfull');
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(res.message)),
                            );
                          })
                          .catchError((err) {
                            print(err);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $err")),
                            );
                          });
                    },
                  ),
            const SizedBox(height: 20),
            // Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('এ্যাকাউন্ট আছে?', style: TextStyle(color: Colors.white)),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap,
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
