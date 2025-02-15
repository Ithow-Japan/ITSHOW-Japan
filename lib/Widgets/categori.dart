import 'package:flutter/material.dart';

class Categori extends StatelessWidget {
  final Color iconColor;
  final String name, time;
  final IconData caicon;

  const Categori({
    super.key,
    required this.iconColor,
    required this.name,
    required this.time,
    required this.caicon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          caicon,
          color: iconColor,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 10,
            color: Color(0xFF9D9D9D),
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
