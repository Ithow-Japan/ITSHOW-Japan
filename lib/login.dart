import 'package:flutter/material.dart';
import 'package:harugo/mypage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyLogin());

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final TextEditingController idControl = TextEditingController();
  final TextEditingController passControl = TextEditingController();
  bool _isObscure = true;
  String _error = "";

  Future<void> login() async {
    final String url = "http://10.0.2.2:3000/mock-login";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": idControl.text,
        "password": passControl.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Mypage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    } else {
      setState(() {
        _error = "아이디나 비밀번호를 확인해주세요.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: Padding(
          padding: const EdgeInsets.only(top: 250),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/rogo.png'),
                const SizedBox(height: 30),
                Form(
                  child: Theme(
                    data: ThemeData(
                      colorScheme: ColorScheme.light(
                        primary: Color(0xFFFD6929),
                      ),
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Color(0xFFAEAEAE),
                          fontSize: 15,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFFFD6929),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: idControl,
                          decoration: const InputDecoration(labelText: '아이디'),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: passControl,
                          decoration: InputDecoration(
                            labelText: '비밀번호',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFFAEAEAE),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: _isObscure,
                        ),
                        const SizedBox(height: 10),
                        if (_error.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              _error,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: 410,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFD6929),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              '로그인',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '회원가입',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFAEAEAE),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
