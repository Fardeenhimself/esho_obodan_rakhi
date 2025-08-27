import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/my_drawer.dart';
import 'package:islamic_app/providers/event_provider.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/screens/event_details_screen.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsProvider);
    final user = ref.watch(loginProvider);

    // show modal for admin
    void _showAddEventDialog(BuildContext context, WidgetRef ref) {
      final _titleController = TextEditingController();
      final _descController = TextEditingController();
      final _locationController = TextEditingController();
      final _dateController = TextEditingController();

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            "নতুন অনুষ্ঠান যোগ করুন",
            style: TextStyle(
              fontFamily: 'bangla',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "অনুষ্ঠানের নাম",
                    labelStyle: TextStyle(fontFamily: 'bangla', fontSize: 16),
                  ),
                  maxLength: 150,
                  style: TextStyle(fontFamily: 'bangla', fontSize: 16),
                ),
                TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: "অনুষ্ঠানের বর্ণনা",
                    labelStyle: TextStyle(fontFamily: 'bangla', fontSize: 16),
                  ),
                  maxLength: 200,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'bangla', fontSize: 16),
                ),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: "ঠিকানা",
                    labelStyle: TextStyle(fontFamily: 'bangla', fontSize: 16),
                  ),
                  style: TextStyle(fontFamily: 'bangla', fontSize: 16),
                ),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: "তারিখ (YYYY-MM-DD HH:MM:SS)",
                    labelStyle: TextStyle(fontFamily: 'bangla', fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "বাদ দিন",
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.pop(ctx),
            ),
            ElevatedButton(
              child: Text(
                "যোগ করুন",
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                if (_titleController.text.trim().isEmpty ||
                    _descController.text.trim().isEmpty ||
                    _locationController.text.trim().isEmpty ||
                    _dateController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "সব ফিল্ড পূরণ করুন",
                        style: TextStyle(fontFamily: 'bangla'),
                      ),
                    ),
                  );
                  return;
                }
                final payload = {
                  "title": _titleController.text,
                  "description": _descController.text,
                  "location": _locationController.text,
                  "event_date": _dateController.text,
                };

                try {
                  await ref
                      .read(eventRepositoryProvider)
                      .addEvent(
                        title: payload['title']!,
                        description: payload['description']!,
                        location: payload['location']!,
                        eventDate: payload['event_date']!,
                      );

                  // Refresh event list
                  ref.invalidate(eventsProvider);

                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("অনুষ্ঠান যোগ সফল হয়েছে ✅")),
                  );
                } catch (e, stack) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('যোগ করা সফল হয় নি')));
                }
                ;
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'অনুষ্ঠান সমুহ',
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: eventsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (events) {
          if (events.isEmpty) {
            return const Center(child: Text('অনুষ্ঠান নেই'));
          }
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => EventDetailScreen(eventId: event.id),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withAlpha(76),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info),
                              const SizedBox(width: 10),
                              Text(
                                event.title,
                                style: TextStyle(
                                  fontFamily: 'bangla',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.calendar_month),
                              const SizedBox(width: 10),
                              Text(
                                event.eventDate,
                                style: TextStyle(
                                  fontFamily: 'bangla',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: user.role == "admin"
          ? FloatingActionButton.extended(
              onPressed: () => _showAddEventDialog(context, ref),
              icon: Icon(Icons.add),
              label: Text(
                'অনুষ্ঠান যোগ করুন',
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
