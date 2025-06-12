import 'package:flutter/material.dart';

class QuizBlockWidget extends StatelessWidget {
  const QuizBlockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffD9D9D9),
          width: 1.0,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      width: 280,
      height: 48,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          child: Text(
            "1. 잘지내셨어요?",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
