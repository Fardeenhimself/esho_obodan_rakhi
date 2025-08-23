import 'package:flutter/material.dart';

class BloodBankScreen extends StatelessWidget {
  const BloodBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ব্লাড ব্যাঙ্ক')),
      body: Center(child: Text('Blood Bank')),
    );
  }
}
