import 'package:flutter/material.dart';
import 'package:harugo/widgets/ButtonWidget.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "퀴즈",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 312,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(10),
                minHeight: 12,
                value: 25.0,
                backgroundColor: Color(0xffD9D9D9),
                valueColor: AlwaysStoppedAnimation(Color(0xffFD6929)),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: 312,
              height: 234,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 30,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Q1. 빈 칸에 들어갈 알맞은 표현은 무엇일까요?"),
                  Text("A 안녕"),
                  Text("B 안녕 오랜만이다."),
                  Text("A _________"),
                  Text("B 어떻게 지냈니?")
                ],
              ),
            ),
            SizedBox(
              height: 312,
            ),
            ButtonWidget("다음 문제")
          ],
        ),
      ),
    );
  }
}
