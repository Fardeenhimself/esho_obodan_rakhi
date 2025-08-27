import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/date_time.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/screens/all_user_screen.dart';
import 'package:islamic_app/screens/donation_ledger.dart';
import 'package:islamic_app/screens/info_screen.dart';
import 'package:islamic_app/screens/settings_screen.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginProvider);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: DrawerHeader(
                  child: Column(
                    children: [
                      Icon(
                        Icons.mosque,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        'এসো অবদান রাখি',
                        style: TextStyle(
                          fontFamily: 'bangla',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DateTimeScreen(),
                    ],
                  ),
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
                  'হোম',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 18,
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
                  'সেটিংস',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 18,
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

              if (user.role == "admin") ...[
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 2,
                  ),
                  leading: Icon(
                    Icons.people,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    'ইউজার সমূহ',
                    style: TextStyle(
                      fontFamily: 'bangla',
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const AllUserScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 2,
                  ),
                  leading: Icon(
                    Icons.receipt_long,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    'অনুদান হিসাব',
                    style: TextStyle(
                      fontFamily: 'bangla',
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const DonationLedgerScreen(),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 12, bottom: 15),
            leading: Icon(
              Icons.favorite_rounded,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'D O N A T E',
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              'Help us keep the app add free',
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 12,
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
