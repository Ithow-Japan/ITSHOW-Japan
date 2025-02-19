import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final List<Map<String, dynamic>> categoryData = [
    {"title": "식당 이용", "progress": 0.8, "text": "이거 354개 주세요"},
    {"title": "교통 이용", "progress": 0.6, "text": "표 한 장 주세요"},
    {"title": "쇼핑 표현", "progress": 0.7, "text": "이거 얼마에요?"},
  ];

  CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
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
            itemCount: categoryData.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(categoryData[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> data) {
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
          Text(data["title"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: data["progress"],
            backgroundColor: Color(0xFFAEAEAE),
            color: Color(0xFFFD6929),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFD6929)),
            onPressed: () {},
            child: Text(data["text"], style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
