import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // 추가

  const LoginButtonWidget(
    this.text, {
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // 터치 시 실행
      child: Container(
        width: 312,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffFD6929),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
