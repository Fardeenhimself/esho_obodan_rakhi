import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_app/services/core/secure_storage_service.dart';

class LogoutRepository {
  final String baseUrl = 'https://halaqa.theabacuses.com/api';

  Future<void> logOut() async {
    final token = await SecureStorageService.read('auth_token');

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
      await SecureStorageService.delete('auth_token');
      await SecureStorageService.delete('user_role');
      await SecureStorageService.delete('user_email');
      await SecureStorageService.delete('user_id');
    } else {
      throw Exception('Failed to logout: ${response.body}');
    }
  }
}
