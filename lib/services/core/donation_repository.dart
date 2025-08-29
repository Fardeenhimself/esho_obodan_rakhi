import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/services/core/secure_storage_service.dart';

class DonationRepository {
  static const baseUrl = "YOUR API KEY";

  // P O S T  D O N A T I O N
  Future<Map<String, dynamic>> makeDonation({
    required String catId,
    required double amount,
  }) async {
    final token = await SecureStorageService.read("auth_token");
    final userId = await SecureStorageService.read("user_id");

    if (token == null || userId == null) {
      throw Exception('Please login first');
    }

    // what we want to send via form
    final payload = {
      "user_id": userId,
      "donation_category_id": catId,
      "amount": amount,
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

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['message'] == null) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Donation failed');
    }
  }

  // G E T  U S E R  D O N A T I O N
  Future<List<Map<String, dynamic>>> getUserDonation() async {
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

    // print("response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception("Failed to fetch donation: ${response.body}");
    }
  }

  // ALL USER DONATION if role == admin
  Future<List<Map<String, dynamic>>> getAllDonations() async {
    final token = await SecureStorageService.read("auth_token");

    if (token == null) {
      throw Exception("Please login first");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/donation/all"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print("All Donations Response: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception("Failed to fetch all donations: ${response.body}");
    }
  }
}
