class User {
  final String id;
  final String role;

  User({required this.id, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], role: json['role']);
  }
}
