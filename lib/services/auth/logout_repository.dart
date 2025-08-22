import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LogoutRepository {
  final String baseUrl = 'https://halaqa.theabacuses.com/api';

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> logOut() async {
    final token = await _storage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$baseUrl/logout');
    final response = await http.get(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // clear the token after logout
      await _storage.delete(key: 'auth_token');
      await _storage.delete(key: 'user_role');
      await _storage.delete(key: 'user_email');
    } else {
      throw Exception('Failed to logout: ${response.body}');
    }
  }
}
