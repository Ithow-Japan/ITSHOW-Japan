import 'package:flutter/material.dart';
import 'mypage.dart';
import 'package:harugo/main.dart'; // 마이페이지 화면

void main() {
  runApp(const NavTestApp());
}

// ✅ Nav.dart 단독 실행을 위한 테스트용 MaterialApp 추가
class NavTestApp extends StatelessWidget {
  const NavTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nav Test',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomeScreen(), // ✅ 네비게이션 테스트 실행
    );
  }
}

// ✅ 실제 네비게이션 바 코드
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MyApp(), // 홈 화면 (추후 변경 가능)
    Placeholder(), // 카테고리 화면
    Placeholder(), // 퀴즈 페이지 (아직 없음)
    Mypage(), // 마이페이지
  ];

  void _onItemTapped(int index) {
    if (index == 2) return; // 퀴즈 페이지는 아직 구현되지 않음
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0
                    ? const Color(0xFFFF6700)
                    : const Color(0xFFAEAEAE)),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu,
                color: _selectedIndex == 1
                    ? const Color(0xFFFF6700)
                    : const Color(0xFFAEAEAE)),
            label: "카테고리",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.storage, color: Color(0xFFAEAEAE)), // 비활성화
            label: "퀴즈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 3
                    ? const Color(0xFFFF6700)
                    : const Color(0xFFAEAEAE)),
            label: "마이페이지",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFF6700),
        unselectedItemColor: const Color(0xFFAEAEAE),
        onTap: _onItemTapped,
      ),
    );
  }
}
