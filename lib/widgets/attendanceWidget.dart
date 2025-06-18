import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:harugo/models/attendance_model.dart';

class AttendanceWidget extends StatelessWidget {
  final List<AttendanceModel> attendanceList;

  const AttendanceWidget({
    super.key,
    required this.attendanceList,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final DateTime monday =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    final List<DateTime> weekDates = List.generate(7, (i) {
      return monday.add(Duration(days: i));
    });

    final attendanceDates = attendanceList
        .map((record) => DateFormat('yyyy-MM-dd').format(record.date))
        .toSet();

    return SizedBox(
      width: 350,
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: weekDates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final date = weekDates[index];
          final formattedDate = DateFormat('yyyy-MM-dd').format(date);
          final isFuture = date.isAfter(currentDate);
          final isAttended = attendanceDates.contains(formattedDate);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 34,
                height: 34,
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
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 24,
                        ),
                ),
              ),
              const SizedBox(height: 6),
            ],
          );
        },
      ),
    );
  }
}
