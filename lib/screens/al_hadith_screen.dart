import 'package:flutter/material.dart';

class AlHadithScreen extends StatelessWidget {
  const AlHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Al-Hadith')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Hadith ${index + 1}'), onTap: () {});
        },
      ),
    );
  }
}
