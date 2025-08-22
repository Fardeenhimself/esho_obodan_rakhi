import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text('মুহতারাম/মুহতারমা,'),
                  const SizedBox(height: 12),
                  Text('আসসালামু আলাইকুম'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
