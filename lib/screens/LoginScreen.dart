import 'package:flutter/material.dart';
import 'package:harugo/widgets/ButtonWidget.dart';
import 'package:harugo/widgets/InputWidget.dart';
import 'package:harugo/widgets/LoginButtonWidget.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF6F3),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 214,
            ),
            Text(
              "HAROGO",
              style: TextStyle(
                fontSize: 36,
                color: Color(0xffFF6700),
              ),
            ),
            SizedBox(height: 63),
            InputWidget("이름을 입력해주세요", false, Icon(Icons.person)),
            InputWidget("비밀번호를 입력해주세요", true, Icon(Icons.lock)),
            SizedBox(
              height: 48,
            ),
            LoginButtonWidget("로그인"),
            SizedBox(
              height: 16,
            ),
            Text(
              "회원가입",
              style: TextStyle(
                fontSize: 10,
                color: Color(0xffAEAEAE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
