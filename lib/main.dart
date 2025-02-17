import 'package:flutter/material.dart';
import 'package:harugo/Widgets/categori.dart';

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/yumi.png'),
                    radius: 60,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '유미',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'berry04283',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF9D9D9D)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 312,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      offset: Offset(0, 0),
                      spreadRadius: 8,
                      blurRadius: 10,
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Categori(
                        iconColor: Color(0xFF0071CE),
                        name: '학습한 문장 수',
                        time: '1h 30m',
                        caicon: Icons.chat_outlined,
                      ),
                      Categori(
                        iconColor: Color(0xFF00883F),
                        name: '누적 출석일',
                        time: '30d',
                        caicon: Icons.calendar_today,
                      ),
                      Categori(
                        iconColor: Color(0xFFC90000),
                        name: '연속 출석일',
                        time: '30d',
                        caicon: Icons.fireplace_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
