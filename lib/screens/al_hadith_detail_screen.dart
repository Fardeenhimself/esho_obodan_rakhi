import 'package:flutter/material.dart';
import 'package:islamic_app/models/core_models/hadith_category.dart';

class AlHadithDetailScreen extends StatelessWidget {
  final HadithCategory category;

  const AlHadithDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: const Center(child: Text('Hadith list will appear here')),
    );
  }
}
