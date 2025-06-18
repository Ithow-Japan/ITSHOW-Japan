class CategoryAchievementModel {
  final int categoryId;
  final int achievement;

  CategoryAchievementModel({
    required this.categoryId,
    required this.achievement,
  });

  factory CategoryAchievementModel.fromJson(Map<String, dynamic> json) {
    return CategoryAchievementModel(
      categoryId: json['category_id'],
      achievement: json['achievement'],
    );
  }
}
