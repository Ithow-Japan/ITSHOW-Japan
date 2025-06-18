import 'package:dio/dio.dart';
import 'package:harugo/Service/cookie_service.dart';

Future<bool> login(String userid, String userpw) async {
  try {
    final response = await ApiClient().dio.post(
          '/login',
          data: {
            'userid': userid,
            'userpw': userpw,
          },
          options: Options(
            validateStatus: (status) => status != null && status < 500,
          ),
        );

    print('로그인 응답: ${response.data}');
    await ApiClient().printCookies();
    return response.statusCode == 200;
  } catch (e) {
    print('로그인 실패: $e');
    return false;
  }
}
