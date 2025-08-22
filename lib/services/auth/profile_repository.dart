import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/auth_model/user_profile.dart';

class ProfileRepository {
  final String baseUrl = "https://halaqa.theabacuses.com/api";

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<UserProfile> fetchProfile() async {
    final token = await _storage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {"Authorization": "Bearer $token"},
    );

    // Debug: print raw response
    print("Profile API raw response: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Decoded JSON: $json");
      return UserProfile.fromJson(data);
    } else {
      throw Exception('Failed to load profile: ${response.body}');
    }
  }
}
