import 'package:flutter/material.dart';
import 'package:harugo/screens/quizScreen.dart';
import 'package:harugo/widgets/ButtonWidget.dart';
import 'package:harugo/widgets/textStyleWidget.dart';

class QuizStartScreen extends StatelessWidget {
  const QuizStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF6F3),
      appBar: AppBar(
        backgroundColor: Color(0xffFFF6F3),
        title: Text(
          "Harugo",
          style: TextStyle(
            color: Color(0xffFF6700),
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextStyled("포코코~"),
            TextStyled("열심히 표현 학습을 했군!"),
            TextStyled("이제 퀴즈를 풀러 가보자~"),
            SizedBox(height: 42),
            Image.asset(
              'assets/quiz_pokoro.png',
              height: 300,
            ),
            SizedBox(height: 67),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizScreen()));
              },
              child: ButtonWidget("퀴즈 시작"),
            )
          ],
        ),
      ),
    );
  }
}
