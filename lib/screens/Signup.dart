import 'package:flutter/material.dart';
import 'package:harugo/widgets/ButtonWidget.dart';
import 'package:harugo/widgets/InputWidget.dart';
import 'package:harugo/widgets/LoginButtonWidget.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF6F3),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 197,
            ),
            Text(
              "Sign up",
              style: TextStyle(
                fontSize: 36,
                color: Color(0xffFF6700),
              ),
            ),
            SizedBox(height: 48),
            InputWidget("아이디", false, Icon(Icons.person)),
            InputWidget("비밀번호", true, Icon(Icons.lock)),
            InputWidget("닉네임", false, Icon(Icons.label)),
            InputWidget("이메일", false, Icon(Icons.email)),
            SizedBox(
              height: 48,
            ),
            LoginButtonWidget("완료"),
          ],
        ),
      ),
    );
  }
}
