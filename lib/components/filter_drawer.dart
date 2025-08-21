import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 100),
        child: Column(
          children: [
            Text(
              'F I L T E R S',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Divider(indent: 50, endIndent: 50),
            const SizedBox(height: 10),
            ListTile(
              leading: Text(
                'Bangla Translation',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              title: CupertinoSwitch(value: true, onChanged: (value) {}),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Text(
                'English Translation',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              title: CupertinoSwitch(value: false, onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
