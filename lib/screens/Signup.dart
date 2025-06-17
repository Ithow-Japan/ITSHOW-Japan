import 'package:flutter/material.dart';
import 'package:harugo/widgets/ButtonWidget.dart';
import 'package:harugo/widgets/InputWidget.dart';
import 'package:harugo/widgets/LoginButtonWidget.dart';
import 'package:harugo/Service/register.dart';
import 'package:harugo/screens/LoginScreen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _onRegister() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final nickname = _nicknameController.text.trim(); // 닉네임 서버에 필요하면 같이 보내세요
    final email = _emailController.text.trim();

    bool success = await register(username, email, password, nickname);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 성공! 로그인해주세요.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Loginscreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 실패. 다시 시도해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF6F3),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 197),
              Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 36,
                  color: Color(0xffFF6700),
                ),
              ),
              SizedBox(height: 48),
              InputWidget("아이디", false, Icon(Icons.person),
                  controller: _usernameController),
              InputWidget("비밀번호", true, Icon(Icons.lock),
                  controller: _passwordController),
              InputWidget("닉네임", false, Icon(Icons.label),
                  controller: _nicknameController),
              InputWidget("이메일", false, Icon(Icons.email),
                  controller: _emailController),
              SizedBox(height: 48),
              LoginButtonWidget("완료", onPressed: _onRegister),
            ],
          ),
        ),
      ),
    );
  }
}
