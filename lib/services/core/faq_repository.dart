import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/core_models/faq.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class FaqRepository {
  static const baseUrl = 'YOUR API KEY';

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
}
