import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/auth_model/all_user.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class UserRepository {
  static const baseUrl = 'https://halaqa.theabacuses.com/api/user';

  // get all users
  Future<List<AllUser>> fetchAllUsers() async {
    final token = await SecureStorageService.read('auth_token');
    if (token == null) throw Exception('No token found');

    final response = await http.get(
      Uri.parse('$baseUrl/all'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      return users
          .map((e) => AllUser.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch users: ${response.statusCode}');
    }
  }

  // Ban User
  Future<void> banUser(String userId, bool isBanned) async {
    final token = await SecureStorageService.read('auth_token');
    if (token == null) throw Exception('No token found');

    final payload = jsonEncode({
      "is_banned": isBanned ? 1 : 0,
    }); // 1 = ban, 0 = unban

    final response = await http.put(
      Uri.parse('$baseUrl/$userId/ban'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: payload,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to ban user: ${response.body}');
    }
  }

  // Make admin
  Future<void> updateUserRole(String userId, String newRole) async {
    final token = await SecureStorageService.read('auth_token');
    if (token == null) throw Exception('No token found');

    final payload = jsonEncode({'role': newRole});

    final response = await http.put(
      Uri.parse('$baseUrl/$userId/role'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: payload,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update role: ${response.statusCode} with ${response.body}',
      );
    }
  }

  Future<AllUser> fetchCurrentUser(String userId) async {
    final token = await SecureStorageService.read('auth_token');
    if (token == null) throw Exception('No token found');

    final response = await http.get(
      Uri.parse('$baseUrl/$userId'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return AllUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch user: ${response.body}');
    }
  }
}
