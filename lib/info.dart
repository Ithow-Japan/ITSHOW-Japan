import 'package:flutter/material.dart';
import 'package:harugo/Widgets/userTextField.dart';
import 'package:harugo/mypage.dart';

void main() => runApp(const Info());

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const InfoScreen(), // ✅ `Scaffold`를 별도 위젯으로 분리
    );
  }
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pushReplacement(
                context, // ✅ `Navigator`를 포함한 `context` 사용
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Mypage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
          ),
        ),
        centerTitle: true,
        title: const Text(
          '계정 정보',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/yumi.png'),
            radius: 60,
          ),
          const SizedBox(height: 10),
          const Text(
            "프로필 사진 수정",
            style: TextStyle(
              color: Color(0xFFFD6929),
              fontSize: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: const UserTextField(
              userId: "berry04283", // 🚀 ID는 수정 불가
              nickname: "yumi",
              email: "berry04283@gmail.com",
            ),
          ),
        ],
      ),
    );
  }
}
