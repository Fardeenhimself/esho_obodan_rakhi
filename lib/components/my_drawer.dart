import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.mosque,
              size: 40,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),

          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            leading: Icon(
              Icons.home_filled,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            title: Text(
              'H O M E',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            title: Text(
              'S E T T I N G S',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            leading: Icon(
              Icons.volunteer_activism,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            title: Text(
              'D O N A T E',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
