import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/auth_model/login_response.dart';
import 'package:islamic_app/services/core/secure_storage_service.dart';

class LoginRepository {
  final String baseUrl = "YOUR API KEY";

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

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final res = LoginResponse.fromJson(body);

      // Check if banned
      // if (res.user.isBanned.toString() == '1') {
      //   throw Exception("You cannot log in, your account is banned");
      // }

      // Save token and role
      await SecureStorageService.write('user_id', res.user.id);
      await SecureStorageService.write('auth_token', res.token);
      await SecureStorageService.write('user_role', res.user.role);
      await SecureStorageService.write('user_email', email);
      // print('id: ${res.user.id}');
      // print('role: ${res.user.role}');
      // print('status: ${res.user.isBanned}');
      // print('message: ${res.message}');
      // print('body: $body');
      return res;
    } else {
      final errorMessage = body['message'] ?? body['error'] ?? 'Login failed';
      print(errorMessage);
      throw Exception(errorMessage);
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
