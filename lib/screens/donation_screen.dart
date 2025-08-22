import 'package:flutter/material.dart';
import 'package:islamic_app/components/data_container.dart';
import 'package:islamic_app/components/my_drawer.dart';
import 'package:islamic_app/screens/make_donation_screen.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('D O N A T I O N S')),
      drawer: MyDrawer(),
      body: Column(
        children: [
          // STATIC CONTAINER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: DataContainer(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 6,
        splashColor: Theme.of(context).colorScheme.onTertiary,
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => MakeDonationScreen()));
        },
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Become a donor',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
