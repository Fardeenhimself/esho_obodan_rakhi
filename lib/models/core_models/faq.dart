class Faq {
  final String id;
  final String question;
  final String answer;

  Faq({required this.id, required this.question, required this.answer});

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}
