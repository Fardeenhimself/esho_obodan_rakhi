import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DeleteRepository {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  Future<bool> deleteUser(String id) async {
    final token = await _storage.read(key: 'auth_token');
    final url = Uri.parse('https://halaqa.theabacuses.com/api/user/$id');

    final response = await http.delete(
      url,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
