import 'package:flutter/material.dart';

class Mosques {
  final String id;
  final String name;
  final IconData starIcon;
  final String rating;
  final String address;
  final String imagePath;

  Mosques({
    required this.id,
    required this.name,
    required this.starIcon,
    required this.rating,
    required this.address,
    required this.imagePath,
  });
}

// Dummy Mosque Datas
final List<Mosques> dummyMosques = [
  Mosques(
    id: '1',
    name: 'খুলনা বিশ্ববিদ্যালয় সেন্ট্রাল জামে মসজিদ',
    starIcon: Icons.star,
    rating: '4.5',
    address: 'খুলনা বিশ্ববিদ্যালয়, খুলনা',
    imagePath: "assets/kumosque.jpg",
  ),

  Mosques(
    id: '2',
    name: 'মারকাজ মসজিদ',
    starIcon: Icons.star,
    rating: '4',
    address: 'ছোট মির্জাপুর রোড, খুলনা',
    imagePath: "assets/markaj.jpg",
  ),
  Mosques(
    id: '3',
    name: 'কেডিএ জামে মসজিদ',
    starIcon: Icons.star,
    rating: '4',
    address: 'মজিদ স্বরনী, খুলনা',
    imagePath: "assets/kda.jpg",
  ),
  Mosques(
    id: '4',
    name: 'বায়তুন আমান জামে মসজিদ',
    starIcon: Icons.star,
    rating: '3.5',
    address: 'ময়লাপোতা মোড়, খুলনা',
    imagePath: "assets/moylapota.jpg",
  ),
  Mosques(
    id: '5',
    name: 'বানৌজা তিতুমীর মসজিদ',
    starIcon: Icons.star,
    rating: '4',
    address: 'বানৌজা তিতুমীর নেভাল, খুলনা',
    imagePath: "assets/bns.jpg",
  ),
  Mosques(
    id: '6',
    name: 'ইকবালনগর জামে মসজিদ',
    starIcon: Icons.star,
    rating: '3',
    address: 'ইকবাল নগর মেইন রোড, খুলনা',
    imagePath: "assets/iqbal.jpg",
  ),
  Mosques(
    id: '7',
    name: 'খুলনা পিটি আই জামে মসজিদ',
    starIcon: Icons.star,
    rating: '4',
    address: 'পিটিআই মোড়, খুলনা',
    imagePath: "assets/pti.jpg",
  ),
  Mosques(
    id: '8',
    name: 'হজরত বেলাল (রাঃ) জামে মসজিদ',
    starIcon: Icons.star,
    rating: '3',
    address: 'ফেরিঘাট মোড়, খুলনা',
    imagePath: "assets/placeholder.jpg",
  ),
  Mosques(
    id: '9',
    name: 'দারুল উলুম জামে মসজিদ',
    starIcon: Icons.star,
    rating: '4.5',
    address: 'মসলমান পাড়া, খুলনা',
    imagePath: "assets/ajmiri.jpg",
  ),
  Mosques(
    id: '10',
    name: 'বায়তুন নূর জামে মসজিদ কমপ্লেক্স',
    starIcon: Icons.star,
    rating: '4',
    address: 'নিউ মার্কেট, খুলনা',
    imagePath: "assets/newmarket.jpg",
  ),
  Mosques(
    id: '11',
    name: 'মতি মসজিদ',
    starIcon: Icons.star,
    rating: '3',
    address: '৫৩, সামসুর রহমান রোড, খুলনা',
    imagePath: "assets/placeholder.jpg",
  ),
  Mosques(
    id: '12',
    name: 'বায়তুল ফালাহ জামে মসজিদ',
    starIcon: Icons.star,
    rating: '4.5',
    address: 'নিউ মার্কেট রোড, খুলনা',
    imagePath: "assets/placeholder.jpg",
  ),
];
