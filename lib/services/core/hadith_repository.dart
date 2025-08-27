import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/core_models/hadith_category.dart';
import 'package:islamic_app/models/core_models/hadith_subcategory.dart';
import 'package:islamic_app/models/core_models/random_hadith.dart';
import 'package:islamic_app/models/core_models/single_hadith.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class HadithRepository {
  final String baseUrl = 'https://hadeethenc.com/api/v1';

  // Lsit of C A T E G O R I E S
  Future<List<HadithCategory>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories/list/?language=bn'),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => HadithCategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // LIST OF S U B  C A T E G O R Y
  Future<List<HadithSubcategory>> fetchHadithSubCategory({
    required String categoryId,
    int page = 1,
    int perPage = 20,
  }) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/hadeeths/list/?language=bn&category_id=$categoryId&page=$page&per_page=$perPage',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List items = data['data'];
      return items.map((json) => HadithSubcategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // S I N G L E  H A D I T H
  Future<SingleHadith> fetchSingleHadith({required String id}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/hadeeths/one/?language=bn&id=$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SingleHadith.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // FETCH random hadith
  Future<RandomHadith> fetchRandomHadith() async {
    final token = await SecureStorageService.read('auth_token');
    if (token == null) throw Exception('No token found. Please login.');

    final response = await http.get(
      Uri.parse('https://halaqa.theabacuses.com/api/hadith/single'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final hadithJson = data['data'] ?? data;
      return RandomHadith.fromJson(hadithJson);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Please login again.');
    } else {
      throw Exception('Failed to load Hadith: ${response.statusCode}');
    }
  }
}
