import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/core_models/faq.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class FaqRepository {
  static const baseUrl = 'YOUR API KEY';

  // get all faqs
  Future<List<Faq>> fetchFaqs() async {
    final token = await SecureStorageService.read('auth_token');
    if (token == null) throw Exception('No token found. Please login.');

    final response = await http.get(
      Uri.parse('$baseUrl/list'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is List) {
        return data.map((e) => Faq.fromJson(e)).toList();
      }
      if (data['data'] != null) {
        return (data['data'] as List).map((e) => Faq.fromJson(e)).toList();
      }
      return [];
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Please login again.');
    } else {
      throw Exception('Failed to load FAQs: ${response.statusCode}');
    }
  }

  // Add faq if role == admin
  Future<Faq> addFaq({required String question, required String answer}) async {
    final token = await SecureStorageService.read('auth_token');
    final userId = await SecureStorageService.read('user_id');
    if (token == null) throw Exception('No token found');
    if (userId == null) throw Exception('No user Id found');

    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'user_id': int.parse(userId),
        'question': question,
        'answer': answer,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      final faqJson = data['data'] ?? data;
      return Faq.fromJson(faqJson);
    } else {
      throw Exception('Failed to add FAQ: ${response.body}');
    }
  }

  // delete faq if role == admin
  Future<void> deleteFaq(String id) async {
    final token = await SecureStorageService.read('auth_token');
    if (token == null) throw Exception('No token found');

    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to delete FAQ: ${response.body}');
    }
  }

  // Single FAQ with detail
  Future<Faq> fetchFaqById(String id) async {
    final token = await SecureStorageService.read("auth_token");
    if (token == null) throw Exception('Token not found');

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
      return Faq.fromJson(eventJson);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Please login again.');
    } else {
      throw Exception('Failed to load event: ${response.statusCode}');
    }
  }
}
