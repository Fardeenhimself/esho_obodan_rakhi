import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/user_provider.dart';

class AllUserScreen extends ConsumerWidget {
  const AllUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(allUsersProvider);

    // ban user function
    void banUser(
      BuildContext context,
      WidgetRef ref,
      String userId,
      String userName,
      bool isBanned,
    ) async {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            isBanned ? 'ইউজার আনব্যান করুন' : 'ইউজার ব্যান করুন',
            style: TextStyle(
              fontFamily: 'bangla',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            isBanned
                ? 'আপনি কি এই ইউজার কে আনব্যান করতে চান?'
                : 'আপনি কি এই ইউজার কে ব্যান করতে চান?',
            style: TextStyle(
              fontFamily: 'bangla',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'না',
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref
                      .read(userActionProvider.notifier)
                      .banUser(userId, !isBanned);
                  ref.invalidate(allUsersProvider);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('সফল হয়েছে')));
                  Navigator.of(context).pop();
                } catch (e, str) {
                  // debugPrint('Error: $e');
                  // debugPrint('Stack Trace $str');
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('সফল হয়নি')));
                }
              },
              child: Text(
                'হ্যাঁ',
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // make admin banner
    void promoteUser(
      BuildContext context,
      WidgetRef ref,
      String userId,
      String userName,
      String role,
    ) async {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            role == 'user' ? 'এ্যাডমিন করুন' : 'ইউজার করুন',
            style: TextStyle(
              fontFamily: 'bangla',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            role == 'user'
                ? 'আপনি কি $userName কে এ্যাডমিন বানাতে চান?'
                : 'আপনি কি $userName কে ইউজার বানাতে চান?',
            style: TextStyle(
              fontFamily: 'bangla',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'না',
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref
                      .read(userActionProvider.notifier)
                      .updateRole(userId, role);
                  ref.invalidate(allUsersProvider);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('সফল হয়েছে')));
                  Navigator.of(context).pop();
                } catch (e, str) {
                  // debugPrint('Error: $e');
                  // debugPrint('Stack Trace $str');
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('সফল হয়নি')));
                }
              },
              child: const Text(
                'হ্যাঁ',
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // M A I N
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'সকল ইউজার',
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: userAsync.when(
        loading: () => Center(child: CupertinoActivityIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (users) {
          if (users.isEmpty) return Center(child: Text('কোন ইউজার নেই'));
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_off, color: Colors.red),
                          const SizedBox(width: 5),
                          Text(
                            'ব্যান করুন',
                            style: TextStyle(
                              fontFamily: 'bangla',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Icon(Icons.add_moderator, color: Colors.green),
                          const SizedBox(width: 5),
                          Text(
                            'এ্যাডমিন করুন',
                            style: TextStyle(
                              fontFamily: 'bangla',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text('${user.email} | role: ${user.role}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => banUser(
                              context,
                              ref,
                              user.id,
                              user.name,
                              user.isBanned,
                            ),
                            icon: Icon(
                              Icons.person_off,
                              color: user.isBanned ? Colors.red : Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () => promoteUser(
                              context,
                              ref,
                              user.id,
                              user.name,
                              user.role,
                            ),
                            icon: Icon(
                              Icons.add_moderator,
                              color: user.role == 'admin'
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
