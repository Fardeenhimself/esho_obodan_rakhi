import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/core_models/hadith_category.dart';

class HadithRepository {
  final String baseUrl = 'https://hadeethenc.com/api/v1';

  Future<List<HadithCategory>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories/list/?language=bn'),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body); // API returns list directly
      return data.map((json) => HadithCategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
