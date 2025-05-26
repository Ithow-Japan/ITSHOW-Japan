import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {
  final String text;
  const LoginButtonWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
