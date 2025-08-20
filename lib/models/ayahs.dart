class Ayahs {
  final int number;
  final String text;
  final int numberInSurah;
  final int page;

  Ayahs({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.page,
  });

  // Diserialization
  factory Ayahs.fromJson(Map<String, dynamic> json) {
    return Ayahs(
      number: json['number'],
      text: json['text'],
      numberInSurah: json['numberInSurah'],
      page: json['page'],
    );
  }
}
