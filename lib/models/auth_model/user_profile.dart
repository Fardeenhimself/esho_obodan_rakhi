class UserProfile {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });

  // Diserialization
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['user']['id'],
      name: json['user']['name'] ?? 'Unknown',
      role: json['user']['role'] ?? 'Unkown',
      email: json['user']['email'] ?? 'Unknown',
      phone: json['user']['phone'] ?? 'Unknown',
    );
  }
}
