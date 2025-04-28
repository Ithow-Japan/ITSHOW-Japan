import 'package:flutter/material.dart';
import 'package:harugo/screens/categoryScreen.dart';
import 'package:harugo/screens/homeScreen.dart';
import 'package:harugo/screens/nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Nav(),
    );
  }
}
