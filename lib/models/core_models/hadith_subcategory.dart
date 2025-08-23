class HadithSubcategory {
  final String id;
  final String title;
  //final List<String> translations;

  HadithSubcategory({
    required this.id,
    required this.title,
    // required this.translations,
  });

  factory HadithSubcategory.fromJson(Map<String, dynamic> json) {
    return HadithSubcategory(
      id: json['id'],
      title: json['title'],
      //translations: List<String>.from(json['translations'] ?? []),
    );
  }
}
