import 'package:flutter/material.dart';
import 'package:islamic_app/components/my_drawer.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('D O N A T I O N S'),
        actions: [
          IconButton(
            onPressed: () {
              // Make a donation
            },
            icon: Icon(Icons.add, size: 30),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Center(child: Text('DONATION SCREEN')),
    );
  }
}
