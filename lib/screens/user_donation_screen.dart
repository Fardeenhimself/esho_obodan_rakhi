import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/donation_provider.dart';

class UserDonationScreen extends ConsumerWidget {
  const UserDonationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final donationsAsync = ref.watch(userDonationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Donations")),
      body: donationsAsync.when(
        data: (donations) {
          if (donations.isEmpty) {
            return const Center(child: Text("No donations yet."));
          }
          return ListView.builder(
            itemCount: donations.length,
            itemBuilder: (context, index) {
              final donation = donations[index];
              return ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: Text("৳ ${donation['amount']}"),
                subtitle: Text(donation['reason'] ?? "No reason"),
                trailing: Text(donation['created_at'] ?? ""),
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
