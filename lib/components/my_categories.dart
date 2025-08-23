import 'package:flutter/material.dart';
import 'package:islamic_app/models/core_models/category.dart';

class MyCategories extends StatelessWidget {
  const MyCategories({super.key, required this.categoryItems});

  final Category categoryItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Icon(
              categoryItems.icon,
              size: 40,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 10),
            Text(
              categoryItems.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'bangla',
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
