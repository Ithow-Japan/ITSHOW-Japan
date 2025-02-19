import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _pokkoroMessage = "오늘도 힘내세요!"; // ✅ JSON 대신 고정 메시지 사용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6F2),
      body: Stack(
        children: [
          // ✅ 포코로 캐릭터 + 말풍선
          Padding(
            padding: EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/pokoro.png', height: 120), // ✅ 포코로 이미지
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 2)
                      ],
                    ),
                    child: Text(
                      _pokkoroMessage, // ✅ "오늘도 힘내세요!" 고정 메시지
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ✅ 아래 스크롤 가능 화면
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 6, spreadRadius: 2)
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAttendanceCheck(),
                        SizedBox(height: 20),
                        _buildCategorySection(),
                        SizedBox(height: 20),
                        _buildSeasonCard(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// ✅ 출석 체크 UI
  Widget _buildAttendanceCheck() {
    List<String> days = ["일", "월", "화", "수", "목", "금", "토"];
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFE6D5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "이번 주 출석체크",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color:
                            index < 4 ? Color(0xFFFD6929) : Color(0xFFAEAEAE),
                        size: 28,
                      ),
                      Text(days[index], style: TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ 카테고리 UI
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "공부하러 가기",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildCategoryCard(index);
            },
          ),
        ),
      ],
    );
  }

  /// ✅ 카테고리 카드 UI
  Widget _buildCategoryCard(int index) {
    List<Map<String, dynamic>> categoryData = [
      {"title": "식당 이용", "progress": 0.8, "text": "이거 354개 주세요"},
      {"title": "교통 이용", "progress": 0.6, "text": "표 한 장 주세요"},
      {"title": "쇼핑 표현", "progress": 0.7, "text": "이거 얼마에요?"},
    ];

    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(categoryData[index]["title"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: categoryData[index]["progress"],
            backgroundColor: Color(0xFFAEAEAE),
            color: Color(0xFFFD6929),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFD6929)),
            onPressed: () {},
            child: Text(categoryData[index]["text"],
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// ✅ 포코로의 계절 (봄 고정)
  Widget _buildSeasonCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "현재 포코로의 계절",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "봄",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/spring_pokoro.png",
            width: 150,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
