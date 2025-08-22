import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/donation_provider.dart';

class UserDonationScreen extends ConsumerWidget {
  const UserDonationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final donationAsync = ref.watch(userDonationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Donation")),
      body: donationAsync.when(
        data: (donation) {
          if (donation == null || donation.isEmpty) {
            return const Center(child: Text("No donations yet."));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: Text("৳ ${donation['amount']}"),
                subtitle: Text(donation['reason'] ?? "No reason"),
                trailing: Text(donation['created_at'] ?? ""),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
