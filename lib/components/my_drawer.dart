import 'package:flutter/material.dart';
import 'package:islamic_app/screens/info_screen.dart';
import 'package:islamic_app/screens/settings_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.mosque,
                  size: 40,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 2,
                ),
                leading: Icon(
                  Icons.home_filled,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: Text(
                  'H O M E',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 2,
                ),
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: Text(
                  'S E T T I N G S',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (ctx) => SettingsScreen()));
                },
              ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 12, bottom: 15),
            leading: Icon(
              Icons.volunteer_activism,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'D O N A T E',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              'Help us keep the app add free',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (ctx) => InfoScreen()));
            },
          ),
        ],
      ),
    );
  }
}
