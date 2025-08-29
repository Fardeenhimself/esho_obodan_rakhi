import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_app/models/auth_model/signup_response.dart';

class SignupRepository {
  final String baseUrl = "YOUR API KEY";

  Future<SignupResponse> signup({
    required String name,
    required String email,
    required String phone,
    required String pin,
    required String pinConfirmation,
  }) async {
    final url = Uri.parse('$baseUrl/signup');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "phone": phone,
        "pin": pin,
        "pin_confirmation": pinConfirmation,
      }),
    );

    if (response.statusCode == 200) {
      return SignupResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to signup");
    }
  }
}
