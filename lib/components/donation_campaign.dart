import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islamic_app/models/core_models/donation_category.dart';

class DonationCampaign extends StatelessWidget {
  const DonationCampaign({super.key, required this.category});

  final DonationCategory category;

  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormat.yMMMMd().format(category.createdAt);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(
            context,
          ).colorScheme.inversePrimary.withAlpha((0.5 * 255).round()),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Divider(color: Theme.of(context).colorScheme.inverseSurface),
              Text('তারিখঃ  $formatDate'),
              const SizedBox(height: 9),
              Text('মোট অর্থ সংগ্রহঃ'),
            ],
          ),
        ),
      ),
    );
  }
}
