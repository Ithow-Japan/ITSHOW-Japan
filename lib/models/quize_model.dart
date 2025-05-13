class QuizModel {
  final int id, user_id, category_id, expressions_id, answer;
  final String question;
  final bool completed;

  QuizModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user_id = json['user_id'],
        category_id = json['category_id'],
        expressions_id = json['expressions_id'],
        answer = json['answer'],
        question = json['question'],
        completed = json['completed'];
}
