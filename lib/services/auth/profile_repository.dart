import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/auth_model/user_profile.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class ProfileRepository {
  final String baseUrl = "YOUR API KEY";

  // Fetch profile
  Future<UserProfile> fetchProfile() async {
    final token = await SecureStorageService.read('auth_token');

    if (token == null) throw Exception('No token found');

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

  // Edit Profile
  Future<UserProfile> updateProfile({
    required String name,
    required String phone,
  }) async {
    final token = await SecureStorageService.read('auth_token');

    if (token == null) throw Exception('No token found');

    final payload = {"name": name, "phone": phone};

    final response = await http.put(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfile.fromJson(data);
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }
}
