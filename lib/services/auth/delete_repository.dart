import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_app/services/core/secure_storage_service.dart';

class DeleteRepository {
  Future<bool> deleteUser(String id) async {
    final token = await SecureStorageService.read('auth_token');
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
