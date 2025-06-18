import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class ApiClient {
  late Dio dio;
  late PersistCookieJar cookieJar;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://172.30.1.58:5000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ));
  }

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  Future<void> init() async {
    // 앱 내부 저장소에 쿠키 저장 위치 지정
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = "${appDocDir.path}/.cookies/";
    cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

    // 여기서 쿠키 매니저 추가
    dio.interceptors.add(CookieManager(cookieJar));
  }

  // 디버깅용 - 현재 저장된 쿠키 확인
  Future<void> printCookies() async {
    final cookies =
        await cookieJar.loadForRequest(Uri.parse('http://172.30.1.58:5000'));
    print('현재 저장된 쿠키: $cookies');
  }
}
