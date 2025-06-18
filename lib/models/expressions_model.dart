class ExpressionsModel {
  final int id, category_id, completed;
  final String korean, japanese, pronunciation, explanation, example;
  ExpressionsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        category_id = json['category_id'],
        korean = json['korean'],
        japanese = json['japanese'],
        pronunciation = json['pronunciation'],
        explanation = json['explanation'],
        example = json['example'],
        completed = json['completed'];
}
