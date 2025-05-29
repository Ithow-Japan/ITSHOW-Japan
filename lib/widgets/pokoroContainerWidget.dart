import 'package:flutter/material.dart';

class PokoroContainerWidget extends StatelessWidget {
  const PokoroContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      width: 312,
      height: 110,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 24, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "포코로 수집 게이지",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 253,
              height: 16,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(10),
                minHeight: 12,
                value: 80 / 100.0,
                backgroundColor: Color(0xffD9D9D9),
                valueColor: AlwaysStoppedAnimation(Color(0xffFD6929)),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text.rich(
              TextSpan(
                text: "다음 수집까지 ",
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff696969),
                ),
                children: [
                  TextSpan(
                    text: "20%",
                    style: TextStyle(
                      color: Color(0xffFD6929),
                    ),
                  ),
                  TextSpan(text: "남았어요!"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
