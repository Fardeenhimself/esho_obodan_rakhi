import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/core_models/event.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class EventRepository {
  static const baseUrl = 'https://halaqa.theabacuses.com/api/event';

  // Fetch list of events
  Future<List<Event>> fetchEvents() async {
    final token = await SecureStorageService.read('auth_token');

    if (token == null) throw Exception('No token found');

    final response = await http.get(
      Uri.parse('$baseUrl/list'),
      headers: {
        "content": "application/json",
        "Authorization": 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return data.map((e) => Event.fromJson(e)).toList();
      }
      if (data['data'] != null) {
        return (data['data'] as List).map((e) => Event.fromJson(e)).toList();
      }
      return [];
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Login required');
    } else {
      throw Exception('Failed: ${response.statusCode}');
    }
  }

  // Add event for role == admin
  Future<Event> addEvent({
    required String title,
    required String description,
    required String location,
    required String eventDate,
  }) async {
    final token = await SecureStorageService.read('auth_token');
    final userId = await SecureStorageService.read('user_id');
    if (token == null) throw Exception("No token found");
    if (userId == null) throw Exception('No user id found');

    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {
        'Accept': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'user_id': int.parse(userId),
        'title': title,
        'description': description,
        'location': location,
        'event_date': eventDate,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      final eventJson = data['data'] ?? data;
      return Event.fromJson(eventJson);
    } else {
      throw Exception('Failed to add event: ${response.body}');
    }
  }

  // Delete event for role == admin
  Future<void> deleteEvent(int id) async {
    final token = await SecureStorageService.read('auth_token');
    if (token == null) throw Exception("No token found");

    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      // Successfully deleted
      return;
    } else {
      throw Exception('Failed to delete event: ${response.body}');
    }
  }

  // Fetch single event
  Future<Event> fetchEventById(int id) async {
    final token = await SecureStorageService.read('auth_token');
    if (token == null) throw Exception('No token found. Please login.');

    final response = await http.get(
      Uri.parse('$baseUrl/single/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final eventJson = data['data'] ?? data;
      return Event.fromJson(eventJson);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Please login again.');
    } else {
      throw Exception('Failed to load event: ${response.statusCode}');
    }
  }
}
