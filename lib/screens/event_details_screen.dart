import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/event_provider.dart';

class EventDetailScreen extends ConsumerWidget {
  final int eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));

    return Scaffold(
      appBar: AppBar(title: const Text('Event Details')),
      body: eventAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (event) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  event.eventDate,
                  style: TextStyle(fontFamily: 'inter', fontSize: 14),
                ),
                const SizedBox(height: 16),
                Text(
                  event.description,
                  style: TextStyle(fontFamily: 'bangla', fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  'Location: ${event.location}',
                  style: TextStyle(fontFamily: 'bangla', fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
