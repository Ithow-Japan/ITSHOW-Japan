import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceWidget extends StatelessWidget {
  final List<String> attendanceDates; // 출석한 날짜 리스트 (yyyy-MM-dd)
  final DateTime currentDate; // 오늘 날짜 기준

  const AttendanceWidget({
    super.key,
    required this.attendanceDates,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime monday =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));

    // 월요일부터 일요일까지 7일 생성
    final List<DateTime> weekDates = List.generate(7, (i) {
      return monday.add(Duration(days: i));
    });

    return SizedBox(
      width: 350,
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: weekDates.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = weekDates[index];
          final formattedDate = DateFormat('yyyy-MM-dd').format(date);
          final isFuture = date.isAfter(currentDate);
          final isAttended = attendanceDates.contains(formattedDate);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isFuture
                      ? Colors.grey.shade300
                      : isAttended
                          ? Colors.orange
                          : Colors.grey.shade400,
                ),
                child: Center(
                  child: isFuture
                      ? Text(
                          DateFormat('E', 'ko').format(date),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 24,
                        ),
                ),
              ),
              SizedBox(height: 6),
            ],
          );
        },
      ),
    );
  }
}
