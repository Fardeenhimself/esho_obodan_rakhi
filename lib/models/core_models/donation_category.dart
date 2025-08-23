class DonationCategory {
  final String id;
  final String name;
  final DateTime createdAt;

  DonationCategory({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory DonationCategory.fromJson(Map<String, dynamic> json) {
    return DonationCategory(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
