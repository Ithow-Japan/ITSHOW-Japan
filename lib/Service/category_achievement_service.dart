import 'package:harugo/models/category_achievement_model.dart';
import 'package:harugo/Service/cookie_service.dart';

class CategoryAchievementService {
  static final ApiClient _apiClient = ApiClient();

  static Future<List<CategoryAchievementModel>> getCategoryAchievement() async {
    List<CategoryAchievementModel> achievements = [];
    try {
      final response = await _apiClient.dio.get('/category-achievement');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        final List<dynamic> dataList = json['data'];

        for (var item in dataList) {
          achievements.add(CategoryAchievementModel.fromJson(item));
        }
        return achievements;
      } else {
        print("서버 응답 오류: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("카테고리 업적 API 호출 중 오류 발생: $e");
      return [];
    }
  }
}
