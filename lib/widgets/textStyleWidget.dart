import 'package:flutter/material.dart';

class TextStyled extends StatelessWidget {
  final String text;
  const TextStyled(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        color: Color(0xff1F1F1F),
      ),
    );
  }
}
