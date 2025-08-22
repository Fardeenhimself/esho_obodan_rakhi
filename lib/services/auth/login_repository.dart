import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/auth_model/login_response.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class LoginRepository {
  final String baseUrl = "https://halaqa.theabacuses.com/api";

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
      await SecureStorageService.write("auth_token", res.token);
      await SecureStorageService.write("user_role", res.user.role);
      await SecureStorageService.write("user_email", email);

      return res;
    } else {
      throw Exception("Failed to login: ${response.body}");
    }
  }

  Future<String?> getToken() async =>
      await SecureStorageService.read("auth_token");
  Future<String?> getRole() async =>
      await SecureStorageService.read("user_role");
  Future<void> logout() async {
    await SecureStorageService.delete("auth_token");
    await SecureStorageService.delete("user_role");
  }
}
