class UserProfile {
  //final String id;
  final String name;
  final String email;
  //final String phone;
  //final String role;

  UserProfile({required this.name, required this.email});

  // Diserialization
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['user']['name'] ?? 'Unknown',
      email: json['user']['email'] ?? 'No email',
    );
  }
}
