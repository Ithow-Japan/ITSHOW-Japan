class QuizModel {
  final int id;
  final int expressions_id;

  final String question;
  final int answer; // 정답 번호 (예: 1~4)
  final int completed;

  QuizModel({
    required this.id,
    required this.expressions_id,
    required this.question,
    required this.answer,
    required this.completed,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      expressions_id: json['expressions_id'],
      question: json['question'],
      answer: json['answer'],
      completed: json['completed'],
    );
  }
}
