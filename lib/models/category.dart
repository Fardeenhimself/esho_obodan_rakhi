import 'package:flutter/material.dart';
import 'package:islamic_app/screens/al_hadith_screen.dart';
import 'package:islamic_app/screens/al_quran_screen.dart';
import 'package:islamic_app/screens/ask_question_screen.dart';
import 'package:islamic_app/screens/donation_screen.dart';
import 'package:islamic_app/screens/events_screen.dart';
import 'package:islamic_app/screens/halaqa_screen.dart';
import 'package:islamic_app/screens/mosques_screen.dart';

class Category {
  final String id;
  final IconData icon;
  final String title;
  final WidgetBuilder page;

  Category({
    required this.id,
    required this.title,
    required this.icon,
    required this.page,
  });
}

// L I S T  O F  C A T E G O R Y
final List<Category> categories = [
  Category(
    id: '1',
    title: 'Al-Quran',
    icon: Icons.menu_book,
    page: (ctx) => const AlQuranScreen(),
  ),
  Category(
    id: '2',
    title: 'Al-Hadith',
    icon: Icons.library_books,
    page: (ctx) => const AlHadithScreen(),
  ),
  Category(
    id: '3',
    title: 'Halaqa',
    icon: Icons.people_alt,
    page: (ctx) => const HalaqaScreen(),
  ),
  Category(
    id: '4',
    title: 'Q/A',
    icon: Icons.question_answer,
    page: (ctx) => const AskQuestionScreen(),
  ),
  Category(
    id: '5',
    title: 'Events',
    icon: Icons.event,
    page: (ctx) => EventsScreen(),
  ),
  Category(
    id: '6',
    title: 'Donation',
    icon: Icons.handshake,
    page: (ctx) => DonationScreen(),
  ),
  Category(
    id: '7',
    title: 'Mosques',
    icon: Icons.mosque_rounded,
    page: (ctx) => MosquesScreen(),
  ),
];
