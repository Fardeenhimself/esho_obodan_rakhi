import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/donation_provider.dart';

class UserDonationScreen extends ConsumerWidget {
  const UserDonationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final donationsAsync = ref.watch(userDonationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "আমার অনুদান সমূহ",
          style: TextStyle(fontFamily: 'bangla', fontSize: 24),
        ),
      ),
      body: donationsAsync.when(
        data: (donations) {
          if (donations.isEmpty) {
            return const Center(
              child: Text(
                "এখনো কোন অনুদান হয়নি.",
                style: TextStyle(fontFamily: 'bangla', fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: donations.length,
            itemBuilder: (context, index) {
              final donation = donations[index];
              return ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: Text(
                  "৳ ${donation['amount']}",
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  "ক্যাম্পেইনঃ ${donation['category_name']}",
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                trailing: Text(
                  donation['created_at'] ?? "",
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
