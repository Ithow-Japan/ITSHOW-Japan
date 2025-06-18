import 'package:flutter/material.dart';
import 'package:harugo/screens/LoginScreen.dart';
import 'package:harugo/screens/PokoroScreen.dart';
import 'package:harugo/screens/Signup.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:harugo/screens/nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <-- 비동기 초기화 준비
  await initializeDateFormatting('ko', null); // <-- 한국어 날짜 포맷 로드
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginscreen(),
    );
  }
}
