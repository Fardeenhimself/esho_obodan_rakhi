import 'package:flutter/material.dart';

class Category {
  final String id;
  final IconData icon;
  final String title;

  Category({required this.id, required this.title, required this.icon});
}

// L I S T  O F  C A T E G O R Y
final List<Category> categories = [
  Category(id: '1', title: 'Al-Quran', icon: Icons.menu_book),
  Category(id: '2', title: 'Al-Hadith', icon: Icons.library_books),
  Category(id: '3', title: 'Halaqa', icon: Icons.people_alt),
  Category(id: '4', title: 'Q/A', icon: Icons.question_answer),
  Category(id: '5', title: 'Events', icon: Icons.event),
  Category(id: '6', title: 'Donation', icon: Icons.handshake),
];
