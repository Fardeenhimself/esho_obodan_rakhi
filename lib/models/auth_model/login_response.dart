import 'package:islamic_app/models/auth_model/user.dart';

class LoginResponse {
  final String? message;
  final String token;
  final User user;

  LoginResponse({this.message, required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
