import 'package:flutter/material.dart';

class PokoroContainerWidget extends StatelessWidget {
  final int gage;
  const PokoroContainerWidget({super.key, required this.gage});

  @override
  Widget build(BuildContext context) {
    final double progressValue = ((gage ?? 0).clamp(0, 100)) / 100.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      width: 312,
      height: 110,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "포코로 수집 게이지",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 260,
              height: 16,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(10),
                minHeight: 12,
                value: progressValue,
                backgroundColor: Color(0xffD9D9D9),
                valueColor: AlwaysStoppedAnimation(Color(0xffFD6929)),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
