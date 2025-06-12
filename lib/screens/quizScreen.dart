import 'package:flutter/material.dart';
import 'package:harugo/widgets/ButtonWidget.dart';
import 'package:harugo/widgets/QuizblockWidget.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "퀴즈",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: Text(
                    "10/12",
                    style: TextStyle(
                      color: Color(0xff828282),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 280,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 16,
                  value: 80 / 100.0,
                  backgroundColor: Color(0xffD9D9D9),
                  valueColor: AlwaysStoppedAnimation(Color(0xffFD6929)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 27,
          ),
          Container(
            width: 280,
            height: 113,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffD9D9D9),
                width: 1.0,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
                Center(
                  child: Text(
                    "Q1. 빈 칸에 들어갈 알맞은 표현은 무엇일까요?",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
          QuizBlockWidget(),
          SizedBox(
            height: 10,
          ),
          QuizBlockWidget(),
          SizedBox(
            height: 10,
          ),
          QuizBlockWidget(),
          SizedBox(
            height: 10,
          ),
          QuizBlockWidget(),
          SizedBox(
            height: 52,
          ),
          ButtonWidget("다음 문제")
        ],
      ),
    );
  }
}
