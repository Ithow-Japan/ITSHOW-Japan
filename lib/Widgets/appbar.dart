import 'package:flutter/material.dart';

class AppbarRogo extends StatelessWidget {
  const AppbarRogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          child: Image.asset(
            'assets/rogo.png',
          ),
        ),
      ),
    );
  }
}
