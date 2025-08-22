import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/my_dialog.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/providers/profilerepository_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('আপনার প্রোফাইল'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => MyDialog(
                  title: 'L O G  O U T',
                  content: 'Are you sure you want to log out?',
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'N O',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await ref.read(loginProvider.notifier).logout();
                          ref.invalidate(profileProvider);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Logout Successful')),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Logout failed: $e')),
                          );
                        }
                      },
                      child: Text(
                        'Y E S',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.logout, size: 30),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // USER PROFILE ICON
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha((0.3 * 255).round()),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profile.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 20,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          profile.email,
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 20,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          profile.phone,
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        alignment: Alignment.center,
                        fixedSize: Size.fromWidth(150),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ইডিট করুন',
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Profile Details Container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha((0.3 * 255).round()),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          top: 5,
                          bottom: 5,
                          right: 10,
                        ),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        onTap: () {},
                        title: Text('আপনার অনুদান'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          top: 5,
                          bottom: 5,
                          right: 10,
                        ),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        onTap: () {},
                        title: Text('আপনার অনুষ্ঠান'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          top: 5,
                          bottom: 5,
                          right: 10,
                        ),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        onTap: () {},
                        title: Text('কৃতিত্ব সমূহ'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),

                  Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 1,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  // LOG OUT
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      top: 15,
                      bottom: 5,
                      right: 10,
                    ),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => MyDialog(
                          title: 'Delete Account',
                          content:
                              'Are you sure you want to delete your account?',
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                'N O',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Y E S',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    title: Text(
                      'ডিলিট একাউন্ট',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    trailing: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        loading: () => CupertinoActivityIndicator(),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
