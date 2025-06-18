import 'package:dio/dio.dart';
import '../models/pokoro_status.model.dart';
import '../Service/cookie_service.dart'; // ApiClient가 이 안에 있다고 가정

class PokoroStatusService {
  static Future<PokoroStatusModel?> getPokoroStatus() async {
    final ApiClient apiClient = ApiClient();

    try {
      final response = await apiClient.dio.get('/pokoroStatus');

      if (response.statusCode == 200) {
        final data = response.data;
        return PokoroStatusModel.fromJson(data);
      } else {
        print("서버 응답 오류: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("포코로 상태 API 호출 중 오류 발생: $e");
      return null;
    }
  }
}
