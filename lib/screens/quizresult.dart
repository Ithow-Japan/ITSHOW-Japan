import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "퀴즈",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Text(
              "14문제 정답!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.asset('assets/pokoro_result.png'),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Container(
                width: 312,
                height: 109,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 30,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
                      child: Text(
                        "포로코 수집 게이지",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 12,
                        value: 0.8,
                        backgroundColor: Color(0xffD9D9D9),
                        valueColor: AlwaysStoppedAnimation(Color(0xffFD6929)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text.rich(
                        TextSpan(
                          text: "다음 옷장 개방까지 ",
                          style: TextStyle(fontSize: 10),
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
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "포코로가 조금 더 성장했어요!",
              style: TextStyle(
                color: Color(0xff696969),
              ),
            ),
            SizedBox(
              height: 104,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffFD6929),
              ),
              width: 312,
              height: 51,
              child: Center(
                child: Text(
                  "더 공부하러가기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
