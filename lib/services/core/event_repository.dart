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
