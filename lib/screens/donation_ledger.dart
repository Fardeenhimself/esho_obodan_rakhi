import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/donation_provider.dart';

class DonationLedgerScreen extends ConsumerWidget {
  const DonationLedgerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final donationsAsync = ref.watch(allDonationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "সকল অনুদান সমূহ",
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: donationsAsync.when(
        data: (donations) {
          if (donations.isEmpty) {
            return const Center(child: Text("অনুদান হয় নি."));
          }
          return ListView.builder(
            itemCount: donations.length,
            itemBuilder: (context, index) {
              final donation = donations[index];
              return ListTile(
                leading: const Icon(Icons.monetization_on, color: Colors.green),
                title: Text("নাম: ${donation['user_name']}"),
                subtitle: Text(
                  "টাকা: ${donation['amount']} | কারন: ${donation['category_name']}",
                ),
                trailing: Text(donation['created_at'] ?? ""),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
