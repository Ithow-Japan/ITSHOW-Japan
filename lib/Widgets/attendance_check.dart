import 'package:flutter/material.dart';

class AttendanceCheck extends StatelessWidget {
  const AttendanceCheck({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> days = ["일", "월", "화", "수", "목", "금", "토"];
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
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
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFE1D0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color:
                              index < 4 ? Color(0xFFFD6929) : Color(0xFFAEAEAE),
                          size: 24,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
