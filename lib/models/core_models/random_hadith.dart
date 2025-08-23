class RandomHadith {
  final int id;
  final String title;
  final String description;

  RandomHadith({
    required this.id,
    required this.title,
    required this.description,
  });

  factory RandomHadith.fromJson(Map<String, dynamic> json) {
    return RandomHadith(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }
}
