import 'package:flutter/material.dart';

class DonationSuccessScreen extends StatelessWidget {
  const DonationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            Text(
              "🎉 জাযাকাল্লাহু খাইর!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'bangla',
                fontSize: 20,
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              ' আপনার অনুদান সম্পন্ন হয়েছে।',
              style: TextStyle(
                fontFamily: 'bangla',
                fontSize: 18,
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.tertiary,
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "ফিরে যান",
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
