class HadithCategory {
  final String id;
  final String title;
  final String hadeethsCount;
  final String? parentId;

  HadithCategory({
    required this.id,
    required this.title,
    required this.hadeethsCount,
    this.parentId,
  });

  factory HadithCategory.fromJson(Map<String, dynamic> json) {
    return HadithCategory(
      id: json['id'],
      title: json['title'],
      hadeethsCount: json['hadeeths_count'],
      parentId: json['parent_id'],
    );
  }
}
