import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/event_provider.dart';
import 'package:islamic_app/providers/login_provider.dart';

class EventDetailScreen extends ConsumerWidget {
  final int eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));
    final user = ref.watch(loginProvider);

    // delete function
    void _showDeleteEventDialog(
      BuildContext context,
      WidgetRef ref,
      int eventId,
    ) async {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('অনুষ্ঠান ডিলিট করবেন?'),
          content: Text('আপনি কি অনুষ্ঠানটি সম্পূর্ণ ডিলিট করতে চান?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('না'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(eventRepositoryProvider).deleteEvent(eventId);

                  ref.invalidate(eventsProvider);

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('ডিলিট হয়েছে')));
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('$e')));
                  Navigator.of(context).pop();
                }
              },
              child: Text('হ্যাঁ'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'অনুষ্ঠান বর্ণনা',
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: user.role == "admin"
            ? [
                IconButton(
                  onPressed: () =>
                      _showDeleteEventDialog(context, ref, eventId),
                  icon: Icon(Icons.delete_forever, size: 30),
                ),
              ]
            : null,
      ),
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
