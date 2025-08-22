import 'package:flutter/material.dart';
import 'package:islamic_app/components/my_card.dart';
import 'package:islamic_app/components/my_categories.dart';
import 'package:islamic_app/components/my_drawer.dart';
import 'package:islamic_app/models/core_models/category.dart';
import 'package:islamic_app/screens/notifications_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('এসো অবদান রাখি'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => NotificationsScreen()),
              );
            },
            icon: Icon(Icons.notifications, size: 30),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // A card that will show at the home header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: MyCard(
                message:
                    'তোমাদের মধ্যে সেই উত্তম যে নিজে কোরআন শিখে এবং অন্যকে শিক্ষা দেয়',
                msgInfo: '~সহীহ বুখারী',
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
                final category = categories[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: category.page));
                  },
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
