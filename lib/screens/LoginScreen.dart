import 'package:flutter/material.dart';
import 'package:harugo/screens/nav.dart';
import 'package:harugo/widgets/InputWidget.dart';
import 'package:harugo/widgets/LoginButtonWidget.dart';
import 'package:harugo/Service/login_service.dart';
import "package:harugo/screens/Signup.dart";
import 'package:harugo/Service/cookie_service.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  Future<void> _onLogin() async {
    await ApiClient().init();
    final id = _idController.text.trim();
    final pw = _pwController.text;

    bool success = await login(id, pw);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 성공!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NavScreen()), // 홈 화면으로 이동
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패. 아이디/비밀번호를 확인하세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF6F3),
      resizeToAvoidBottomInset: true, // 키보드로 인한 overflow 방지
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text(
                  "HARUGO",
                  style: TextStyle(fontSize: 36, color: Color(0xffFF6700)),
                ),
                const SizedBox(height: 63),
                InputWidget(
                  "이름을 입력해주세요",
                  false,
                  const Icon(Icons.person),
                  controller: _idController,
                ),
                InputWidget(
                  "비밀번호를 입력해주세요",
                  true,
                  const Icon(Icons.lock),
                  controller: _pwController,
                ),
                const SizedBox(height: 48),
                LoginButtonWidget("로그인", onPressed: _onLogin),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Signup()),
                    );
                  },
                  child: const Text(
                    "회원가입",
                    style: TextStyle(fontSize: 10, color: Color(0xffAEAEAE)),
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
