import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'এ্যাপ্স সেটিংস',
          style: TextStyle(fontFamily: 'bangla', fontSize: 24),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withAlpha((0.3 * 255).round()),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('ডার্ক মোড'),
                    titleTextStyle: TextStyle(
                      fontFamily: 'bangla',
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                    trailing: CupertinoSwitch(
                      value: currentThemeMode == ThemeMode.dark,
                      onChanged: (isDark) {
                        ref.read(themeProvider.notifier).toggleTheme();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('নোটিফিকেশন'),
                    titleTextStyle: TextStyle(
                      fontFamily: 'bangla',
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                    trailing: CupertinoSwitch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
