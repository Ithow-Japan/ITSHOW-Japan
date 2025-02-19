import 'package:flutter/material.dart';

class AttendanceCheck extends StatelessWidget {
  const AttendanceCheck({super.key});

  @override
  Widget build(BuildContext context) {
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
}
