import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/my_dialog.dart';
import 'package:islamic_app/models/auth_model/user_profile.dart';
import 'package:islamic_app/providers/delete_provider.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/providers/profilerepository_provider.dart';
import 'package:islamic_app/screens/user_donation_screen.dart';
import 'package:islamic_app/services/auth/login_or_register.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    // the bottom modal form
    void showEditProfile(UserProfile profile) {
      final _nameController = TextEditingController(text: profile.name);
      final _phoneController = TextEditingController(text: profile.phone);

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'আপনার প্রোফাইল নাম চেঞ্জ করুন',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                autocorrect: false,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),

                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "নাম",
                  labelStyle: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                autocorrect: false,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "ফোন",
                  labelStyle: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 20),
              Consumer(
                builder: (context, ref, _) {
                  final editState = ref.watch(profileEditProvider);
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    onPressed: editState.isLoading
                        ? null
                        : () async {
                            try {
                              // Update profile
                              await ref
                                  .read(profileEditProvider.notifier)
                                  .updateProfile(
                                    name: _nameController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                  );

                              // Refresh profile provider and wait for new data
                              await ref.refresh(profileProvider.future);

                              Navigator.of(ctx).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'প্রোফাইল ইডিট সফল হয়েছে',
                                    style: TextStyle(
                                      fontFamily: 'bangla',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'সফল হয় নি',
                                    style: TextStyle(
                                      fontFamily: 'bangla',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                    child: editState.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "সেভ",
                            style: TextStyle(
                              fontFamily: 'bangla',
                              fontSize: 16,
                            ),
                          ),
                  );
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'আপনার প্রোফাইল',
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, size: 30),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => MyDialog(
                  title: 'লগ আউট করুন',
                  content: 'আপনি কি লগ আউট করতে চান?',
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'না',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await ref.read(loginProvider.notifier).logout();

                          // Refresh profile
                          ref.refresh(profileProvider);

                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('লগ আউট সফল')));
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('লগ আউট হয়নি')),
                          );
                        }
                      },
                      child: Text(
                        'হ্যাঁ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => Center(child: CupertinoActivityIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
        data: (profile) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Profile Card
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
                      SizedBox(height: 10),
                      Text(
                        profile.name,
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 20,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
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
                          SizedBox(width: 4),
                          Text(
                            profile.email,
                            style: TextStyle(
                              fontFamily: 'inter',
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                          SizedBox(width: 4),
                          Text(
                            profile.phone,
                            style: TextStyle(
                              fontFamily: 'inter',
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => showEditProfile(profile),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          alignment: Alignment.center,
                          fixedSize: Size.fromWidth(150),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ইডিট করুন',
                              style: TextStyle(
                                fontFamily: 'bangla',
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
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

              /// Profile Options
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
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => UserDonationScreen()),
                      ),
                      title: Text('আপনার অনুদান'),
                      titleTextStyle: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      onTap: () {},
                      title: Text('আপনার অনুষ্ঠান'),
                      titleTextStyle: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      onTap: () {},
                      title: Text('কৃতিত্ব সমূহ'),
                      titleTextStyle: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (_) => MyDialog(
                            title: 'ডিলিট এ্যাকাউন্ট',
                            content: 'আপনি আপনার এ্যাকাউন্ট ডিলিট করতে চান?',
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'না',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  try {
                                    await ref
                                        .read(deleteProvider)
                                        .deleteUser(profile.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("ডিলিট সফল"),
                                      ),
                                    );
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (_) => const LoginOrRegister(),
                                      ),
                                      (route) => false,
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("সফল হয়নি")),
                                    );
                                  }
                                },
                                child: Text(
                                  'হ্যাঁ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      title: Text('ডিলিট একাউন্ট'),
                      titleTextStyle: TextStyle(
                        fontFamily: 'bangla',
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.error,
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
        ),
      ),
    );
  }
}
