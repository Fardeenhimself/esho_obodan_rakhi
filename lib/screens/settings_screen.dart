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
      appBar: AppBar(title: Text('এ্যাপ্স সেটিংস')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text('ডার্ক মোড'),
              trailing: CupertinoSwitch(
                value: currentThemeMode == ThemeMode.dark,
                onChanged: (isDark) {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text('নোটিফিকেশন'),
              trailing: CupertinoSwitch(value: false, onChanged: (value) {}),
            ),
          ),
        ],
      ),
    );
  }
}
