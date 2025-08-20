import 'package:flutter/material.dart';
import 'package:islamic_app/components/my_card.dart';
import 'package:islamic_app/components/my_categories.dart';
import 'package:islamic_app/components/my_drawer.dart';
import 'package:islamic_app/models/category.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('এসো অবদান রাখি')),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // A card that will show at the home header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: MyCard(
                message: 'Even a smile is considered as charity',
                msgInfo: 'Al-Hadith',
              ),
            ),
            const SizedBox(height: 30),
            const Divider(indent: 100, endIndent: 100, thickness: 2),
            const SizedBox(height: 30),

            // Categories
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 2,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {},
                  child: MyCategories(categoryItems: categories[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
