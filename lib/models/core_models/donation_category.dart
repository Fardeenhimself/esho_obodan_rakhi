class DonationCategory {
  final String id;
  final String name;
  final double balance;
  final double target;
  final double remaining;
  final DateTime createdAt;
  final DateTime? updatedAt;

  DonationCategory({
    required this.id,
    required this.name,
    required this.balance,
    required this.remaining,
    required this.target,
    required this.createdAt,
    this.updatedAt,
  });

  factory DonationCategory.fromJson(Map<String, dynamic> json) {
    return DonationCategory(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      balance: double.tryParse(json['balance'].toString()) ?? 0.0,
      remaining: double.tryParse(json['remaining'].toString()) ?? 0.0,
      target: double.tryParse(json['target'].toString()) ?? 0.0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'target': target,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
