class AllUser {
  final String id;
  final String name;
  final String email;
  final bool isBanned;
  final String role;

  AllUser({
    required this.id,
    required this.name,
    required this.email,
    required this.isBanned,
    required this.role,
  });

  factory AllUser.fromJson(Map<String, dynamic> json) {
    return AllUser(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'user',
      isBanned: json['is_banned'].toString() == '1',
    );
  }
}
