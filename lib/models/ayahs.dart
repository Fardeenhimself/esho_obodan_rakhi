// class Ayahs {
//   final int number;
//   final String text;
//   final int numberInSurah;
//   final int page;

//   Ayahs({
//     required this.number,
//     required this.text,
//     required this.numberInSurah,
//     required this.page,
//   });

//   // Diserialization
//   factory Ayahs.fromJson(Map<String, dynamic> json) {
//     return Ayahs(
//       number: json['number'],
//       text: json['text'],
//       numberInSurah: json['numberInSurah'],
//       page: json['page'],
//     );
//   }
// }
class Ayahs {
  final int number;
  final int numberInSurah;
  final int page;
  final String arabicText;
  final String banglaText;

  Ayahs({
    required this.number,
    required this.numberInSurah,
    required this.page,
    required this.arabicText,
    required this.banglaText,
  });

  factory Ayahs.fromJson({
    required Map<String, dynamic> arabic,
    required Map<String, dynamic> bangla,
  }) {
    return Ayahs(
      number: arabic['number'],
      numberInSurah: arabic['numberInSurah'],
      page: arabic['page'],
      arabicText: arabic['text'],
      banglaText: bangla['text'],
    );
  }
}
