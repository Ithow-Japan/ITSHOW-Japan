import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:harugo/models/category_model.dart';

class CategoryService {
  static final String baseUrl = "http://192.168.219.105:5000";
  static final String category = "/categories";

  static Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> categoryInstances = [];
    final url = Uri.parse('$baseUrl$category');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> categoryItem = jsonDecode(response.body);
      for (var item in categoryItem) {
        categoryInstances.add(CategoryModel.fromJson(item));
      }
      return categoryInstances;
    }

    throw Error();
  }
}
