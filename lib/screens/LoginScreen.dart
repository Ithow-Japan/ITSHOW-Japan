import 'package:flutter/material.dart';
import 'package:harugo/widgets/ButtonWidget.dart';
import 'package:harugo/widgets/InputWidget.dart';
import 'package:harugo/widgets/LoginButtonWidget.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InputWidget("이름을 입력해주세요", false, Icon(Icons.person)),
          InputWidget("비밀번호를 입력해주세요", true, Icon(Icons.lock)),
          LoginButtonWidget("로그인")
        ],
      ),
    );
  }
}
