class User {
  final String id;
  final String role;
  final bool? isBanned;

  User({required this.id, required this.role, this.isBanned});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      role: json['role'],
      isBanned: json['is_banned']?.toString() == '0',
    );
  }
}
