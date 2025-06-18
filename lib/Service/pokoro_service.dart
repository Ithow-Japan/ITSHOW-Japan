import 'package:dio/dio.dart';
import 'package:harugo/models/pokoro_model.dart';
import 'package:harugo/Service/cookie_service.dart';

class PokoroService {
  static final ApiClient _apiClient = ApiClient();

  static Future<List<PokoroModel>> getPokoro() async {
    List<PokoroModel> pokoro = [];

    try {
      final response = await _apiClient.dio.get("/pokoro");

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        return [PokoroModel.fromJson(json)];
      } else {
        print("서버 응답 오류: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("포코로 API 호출 중 오류 발생: $e");
      return [];
    }
  }

  static Future<String?> getPokoroImage() async {
    try {
      final response = await _apiClient.dio.get("/pokoro");

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        return json['image'] as String?;
      } else {
        print("서버 응답 오류: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("포코로 API 호출 중 오류 발생: $e");
      return null;
    }
  }
}
