import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/auth_model/login_response.dart';

class LoginRepository {
  final String baseUrl = "https://halaqa.theabacuses.com/api";

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<LoginResponse> login({
    required String email,
    required String pin,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "pin": pin}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final res = LoginResponse.fromJson(json);

      // Save token and role
      await _storage.write(key: "auth_token", value: res.token);
      await _storage.write(key: "user_role", value: res.user.role);
      await _storage.write(key: "user_email", value: email);

      return res;
    } else {
      throw Exception("Failed to login: ${response.body}");
    }
  }

  Future<String?> getToken() async => await _storage.read(key: "auth_token");
  Future<String?> getRole() async => await _storage.read(key: "user_role");
  Future<void> logout() async {
    await _storage.delete(key: "auth_token");
    await _storage.delete(key: "user_role");
  }
}
