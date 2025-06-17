import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class ApiClient {
  late Dio dio;
  late CookieJar cookieJar;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.219.105:5000',
    ));
  }

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  Future<void> init() async {
    // 앱 내부 저장소에 쿠키 저장
    final appDocDir = await getApplicationDocumentsDirectory();
    cookieJar =
        PersistCookieJar(storage: FileStorage("${appDocDir.path}/.cookies/"));
    dio.interceptors.add(CookieManager(cookieJar));
  }
}
