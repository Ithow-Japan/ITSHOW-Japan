import 'package:flutter/material.dart';
import 'package:harugo/widgets/categoryWidget.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "HARUGO",
          style: TextStyle(
            fontSize: 26,
            color: Color(0x00ff6700),
          ),
        ),
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            CategoryWidget(),
            SizedBox(
              width: 8,
            ),
            CategoryWidget(),
            SizedBox(
              width: 8,
            ),
            CategoryWidget()
          ],
        ),
      ),
    );
  }
}
