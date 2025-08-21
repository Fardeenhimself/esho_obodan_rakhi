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

  void register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final pin = _passwordController.text.trim();
    final pin_confirmation = _confirmPWController.text.trim();

    // 🛡 Validation checks
    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        pin.isEmpty ||
        pin_confirmation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('সব ফিল্ড পূরণ করুন'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!isValidEmailDomain(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('সঠিক ইমেইল ব্যবহার করুন'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (pin != pin_confirmation) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('পাসওয়ার্ড মিলছে না'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 📞 Optional: phone length check
    if (phone.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ফোন নাম্বার ১১ সংখ্যার হতে হবে'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ✅ If all checks pass, proceed with signup
    setState(() {
      isLoading = true;
    });

    final signupFuture = ref.refresh(
      signupProvider({
        "name": name,
        "email": email,
        "phone": phone,
        "pin": pin,
        "pin_confirmation": pin_confirmation,
      }).future,
    );

    signupFuture
        .then((res) {
          print('successfull');
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(res.message)));
        })
        .catchError((err) {
          print(err);
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: $err")));
        });
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
                : MyButton(text: 'রেজিস্টার', onTap: register),
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
