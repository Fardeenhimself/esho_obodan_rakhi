import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/services/core/secure_storage_service.dart';

class DonationRepository {
  static const baseUrl = "https://halaqa.theabacuses.com/api";

  // P O S T  D O N A T I O N
  Future<Map<String, dynamic>> makeDonation({
    required double amount,
    String? reason,
  }) async {
    final token = await SecureStorageService.read("auth_token");
    final userId = await SecureStorageService.read("user_id");

    if (token == null || userId == null) {
      throw Exception('Please login first');
    }

    // what we want to send via form
    final payload = {
      "user_id": userId,
      "amount": amount,
      "reason": reason ?? '',
    };

    // hit the API
    final response = await http.post(
      Uri.parse("$baseUrl/donation"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Donation failed: ${response.body}');
    }
  }

  // G E T  U S E R  D O N A T I O N
  Future<Map<String, dynamic>> getUserDonation() async {
    final token = await SecureStorageService.read("auth_token");
    final userId = await SecureStorageService.read("user_id");

    if (token == null || userId == null) {
      throw Exception("Please login first");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/donation/$userId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print("📦 Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic>) {
        return data;
      } else {
        return {}; // no donation exists
      }
    } else {
      throw Exception("Failed to fetch donation: ${response.body}");
    }
  }
}
