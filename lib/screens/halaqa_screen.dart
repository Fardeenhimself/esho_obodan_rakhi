import 'package:flutter/material.dart';

class HalaqaScreen extends StatelessWidget {
  const HalaqaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'হালাকা',
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withAlpha(76),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'শেষ জামানায় ঈমান আঁকড়ে থাকার উপায় ও কৌশল',
                      style: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(thickness: 3),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.person),
                        const SizedBox(width: 12),
                        Text(
                          'বক্তাঃ শায়েখ আহমাদুল্লাহ (হাফিঃ)',
                          style: TextStyle(
                            fontFamily: 'bangla',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'স্থানঃ আব্দুর রশীদ মসজিদ, পশ্চিম বানিয়ে খামার, খুলনা',
                            style: TextStyle(
                              fontFamily: 'bangla',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.audio_file),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'অডিও ফাইল',
                            style: TextStyle(
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
            ),
          ],
        ),
      ),
    );
  }
}
