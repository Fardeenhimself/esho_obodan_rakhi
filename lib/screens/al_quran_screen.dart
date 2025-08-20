import 'package:flutter/material.dart';

class AlQuranScreen extends StatelessWidget {
  const AlQuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Al-Quran')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Sura ${index + 1}'), onTap: () {});
        },
      ),
    );
  }
}
