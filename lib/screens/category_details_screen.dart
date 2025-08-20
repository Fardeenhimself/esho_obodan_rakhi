import 'package:flutter/material.dart';
import 'package:islamic_app/models/category.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: Center(child: Icon(category.icon)),
    );
  }
}
