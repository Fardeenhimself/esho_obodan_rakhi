import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/models/core_models/event.dart';
import 'package:islamic_app/services/core/event_repository.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository();
});

// all events
final eventsProvider = FutureProvider<List<Event>>((ref) async {
  final repo = ref.watch(eventRepositoryProvider);
  return repo.fetchEvents();
});

//single evnets
final eventDetailProvider = FutureProvider.family<Event, int>((ref, id) async {
  final repo = ref.watch(eventRepositoryProvider);
  return repo.fetchEventById(id);
});

// add evnet if role == admin
final addEventProvider = FutureProvider.family
    .autoDispose<Event, Map<String, String>>((ref, payload) async {
      final repo = ref.watch(eventRepositoryProvider);
      return repo.addEvent(
        title: payload['title']!,
        description: payload['description']!,
        location: payload['location']!,
        eventDate: payload['event_date']!,
      );
    });

// delete event for role == admin
final deleteEventProvider = Provider((ref) => DeleteEvent(ref));

class DeleteEvent {
  final Ref ref;
  DeleteEvent(this.ref);

  Future<void> call(int eventId) async {
    final repo = ref.read(eventRepositoryProvider);
    await repo.deleteEvent(eventId);

    ref.invalidate(eventsProvider);
    ref.invalidate(eventDetailProvider(eventId));
  }
}
