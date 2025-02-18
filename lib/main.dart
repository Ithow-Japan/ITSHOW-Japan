import 'package:flutter/material.dart';
import 'package:harugo/Widgets/categori.dart';
import 'package:harugo/Widgets/list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Row(
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
            SizedBox(
              height: 16,
            ),
            UserList(
              listIcon: Icons.headset_mic,
              listText: '고객센터',
            ),
            UserList(
              listIcon: Icons.help_outline_rounded,
              listText: 'FAQ',
            ),
            UserList(
              listIcon: Icons.group,
              listText: '공식 SNS 방문하기',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Divider(
                color: Color(0xFFDCDCDC),
                thickness: 1,
                height: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              child: Row(
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFFF6969),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Color(0xFFFF6969),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
