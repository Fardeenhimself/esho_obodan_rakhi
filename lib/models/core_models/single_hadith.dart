class SingleHadith {
  final String id;
  final String title;
  final String hadeeth;
  final String attribution;
  final String grade;
  final String explanation;
  // final List<String> hints;

  SingleHadith({
    required this.id,
    required this.title,
    required this.hadeeth,
    required this.attribution,
    required this.grade,
    required this.explanation,
    // required this.hints,
  });

  factory SingleHadith.fromJson(Map<String, dynamic> json) {
    return SingleHadith(
      id: json['id'],
      title: json['title'],
      hadeeth: json['hadeeth'],
      attribution: json['attribution'],
      grade: json['grade'],
      explanation: json['explanation'],
      // hints: List<String>.from(json['hints'] ?? []),
    );
  }
}
