import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/auth_model/user_profile.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class ProfileRepository {
  final String baseUrl = "https://halaqa.theabacuses.com/api";

  Future<UserProfile> fetchProfile() async {
    final token = await SecureStorageService.read('auth_token');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfile.fromJson(data);
    } else {
      throw Exception('Failed to load profile: ${response.body}');
    }
  }
}
