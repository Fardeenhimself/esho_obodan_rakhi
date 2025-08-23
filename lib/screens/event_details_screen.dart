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
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(
                    context,
                  ).colorScheme.secondaryContainer.withAlpha(76),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    event.title,
                    style: TextStyle(
                      fontFamily: 'bangla',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          event.description,
                          style: TextStyle(fontFamily: 'bangla', fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      const SizedBox(width: 10),
                      Text(
                        event.location,
                        style: TextStyle(fontFamily: 'bangla', fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.calendar_month),
                      const SizedBox(width: 10),
                      Text(
                        event.eventDate,
                        style: TextStyle(fontFamily: 'bangla', fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
