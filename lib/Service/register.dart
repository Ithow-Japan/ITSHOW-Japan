import 'package:harugo/Service/cookie_service.dart';
import 'package:dio/dio.dart';

Future<bool> register(
    String userid, String email, String userpw, String nickname) async {
  try {
    await ApiClient().init(); // 반드시 쿠키 매니저 초기화
    final response = await ApiClient().dio.post(
          '/register',
          data: {
            'userid': userid,
            'userpw': userpw,
            'nickname': nickname,
            'email': email,
          },
          options: Options(
            validateStatus: (status) => status != null && status < 500,
          ),
        );

    print('status code: ${response.statusCode}');
    print('response data: ${response.data}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('서버 에러 메시지: ${response.data}');
      return false;
    }
  } catch (e) {
    print('회원가입 실패: $e');
    return false;
  }
}
