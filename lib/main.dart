import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset('assets/harugo.png'),
              ),
              SizedBox(
                width: 220,
              ),
              Icon(Icons.settings),
            ],
          ),
        ),
        body: CircleAvatar(
          child: Image.asset(
            'assets/harugo.png',
          ),
        ),
      ),
    );
  }
}
