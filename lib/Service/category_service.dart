import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:harugo/models/category_model.dart';

class CategoryService {
  static final String baseUrl = "http://10.0.2.2:5000/categories";

  static Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> categoryInstances = [];
    try {
      final url = Uri.parse(baseUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> categoryItem = jsonDecode(response.body);
        for (var item in categoryItem) {
          categoryInstances.add(CategoryModel.fromJson(item));
        }
        return categoryInstances;
      } else {
        print("서버 응답 오류: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("카테고리 API 호출 중 오류 발생: $e");
      return [];
    }
  }
}
