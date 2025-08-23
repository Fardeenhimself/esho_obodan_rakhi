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
