import 'package:flutter/material.dart';
import 'main.dart'; // 홈 화면
import 'Widgets/category_list.dart'; // 카테고리 화면
import 'mypage.dart'; // 마이페이지 화면

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MyApp(), // 홈 화면
    CategoryList(), // 카테고리 화면
    Placeholder(), // 퀴즈 페이지 (현재 없음, 빈 화면 대체)
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0
                    ? Color(0xFFFF6700)
                    : Color(0xFFAEAEAE)),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu,
                color: _selectedIndex == 1
                    ? Color(0xFFFF6700)
                    : Color(0xFFAEAEAE)),
            label: "카테고리",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage, color: Color(0xFFAEAEAE)), // 비활성화
            label: "퀴즈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 3
                    ? Color(0xFFFF6700)
                    : Color(0xFFAEAEAE)),
            label: "마이페이지",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFF6700),
        unselectedItemColor: Color(0xFFAEAEAE),
        onTap: _onItemTapped,
      ),
    );
  }
}
