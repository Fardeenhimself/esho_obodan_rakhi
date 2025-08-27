import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/services/core/secure_storage_service.dart';
import 'package:islamic_app/models/core_models/donation_category.dart';

class DonationCategoryRepository {
  static const baseUrl = 'https://halaqa.theabacuses.com/api/donation/category';

  // All Categories
  Future<List<DonationCategory>> fetchCategories() async {
    final token = await SecureStorageService.read('auth_token');

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => DonationCategory.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  /// add target for each category if role == admin
  Future<bool> addCategoryTarget({
    required String name,
    required String target,
  }) async {
    final token = await SecureStorageService.read('auth_token');

    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': name, 'target': target}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error: ${response.statusCode}');
      print('Body: ${response.body}');
      throw Exception('Failed to add category target');
    }
  }
}
