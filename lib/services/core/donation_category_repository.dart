import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/services/core/secure_storage_service.dart';
import 'package:islamic_app/models/core_models/donation_category.dart';

class DonationCategoryRepository {
  Future<List<DonationCategory>> fetchCategories() async {
    final token = await SecureStorageService.read('auth_token');

    final response = await http.get(
      Uri.parse('https://halaqa.theabacuses.com/api/donation/category'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => DonationCategory.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
