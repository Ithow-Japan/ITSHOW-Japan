import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Harugo Login',
      home: LogInScreen(),
    );
  }
}

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // 🌐 로그인 API 호출 함수
  Future<void> _login() async {
    setState(() {
      _isLoading = true; // 로딩 시작
    });

    String apiUrl = 'http://your-server-ip:3000/login'; // 🔹 실제 서버 주소로 변경 필요
    Map<String, String> headers = {"Content-Type": "application/json"};

    // 요청 데이터
    Map<String, String> body = {
      "userid": _idController.text,
      "password": _passwordController.text
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // 성공 응답 처리
        var jsonResponse = jsonDecode(response.body);
        _showSnackBar("로그인 성공: ${jsonResponse['message']}");
      } else {
        // 실패 응답 처리
        var jsonResponse = jsonDecode(response.body);
        _showSnackBar("로그인 실패: ${jsonResponse['error']}");
      }
    } catch (e) {
      _showSnackBar("서버 연결 오류: $e");
    }

    setState(() {
      _isLoading = false; // 로딩 종료
    });
  }

  // 스낵바 표시 함수
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 로고
              Image.asset(
                'assets/rogo.png',
                width: 200,
              ),
              SizedBox(height: 40),

              // 아이디 입력 필드
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: '아이디',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFD6929)),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // 비밀번호 입력 필드
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFD6929)),
                  ),
                ),
              ),
              SizedBox(height: 32),

              // 로그인 버튼
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login, // 로딩 중이면 버튼 비활성화
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD6929),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white) // 로딩 표시
                      : Text(
                          '로그인',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                ),
              ),
              SizedBox(height: 16),

              // 회원가입 버튼
              TextButton(
                onPressed: () {},
                child: Text(
                  '회원가입',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
