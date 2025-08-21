import 'package:flutter/material.dart';
import 'package:islamic_app/screens/donation_screen.dart';
import 'package:islamic_app/screens/events_screen.dart';
import 'package:islamic_app/screens/home_page.dart';
import 'package:islamic_app/screens/profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // keep track of which screen
  int _initialIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Function to change the screen
    void _toggleScreen(int index) {
      setState(() {
        _initialIndex = index;
      });
    }

    // List of screens
    final List _screens = [
      HomePage(),
      DonationScreen(),
      EventsScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: _screens[_initialIndex],
      bottomNavigationBar: NavigationBar(
        labelTextStyle: WidgetStatePropertyAll(
          Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        indicatorColor: Theme.of(context).colorScheme.onPrimary,
        selectedIndex: _initialIndex,
        onDestinationSelected: _toggleScreen,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_filled,
              color: Theme.of(context).colorScheme.tertiary,
              size: 30,
            ),
            label: 'হোম',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.tertiary,
              size: 30,
            ),
            label: 'অনুদান',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.event,
              color: Theme.of(context).colorScheme.tertiary,
              size: 30,
            ),
            label: 'অনুষ্ঠান',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.account_circle,
              color: Theme.of(context).colorScheme.tertiary,
              size: 30,
            ),
            label: 'প্রোফাইল',
          ),
        ],
      ),
    );
  }
}
