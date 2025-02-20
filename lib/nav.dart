import 'package:flutter/material.dart';
import 'mypage.dart';
import 'package:harugo/main.dart';

void main() {
  runApp(const NavTestApp());
}

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MyApp(),
    Placeholder(),
    Placeholder(),
    Mypage(),
  ];

  void _onItemTapped(int index) {
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
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFF6700),
        unselectedItemColor: const Color(0xFFAEAEAE),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0
                  ? const Color(0xFFFF6700)
                  : const Color(0xFFAEAEAE),
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.storage,
              color: _selectedIndex == 1
                  ? const Color(0xFFFF6700)
                  : const Color(0xFFAEAEAE),
            ),
            label: "퀴즈",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: _selectedIndex == 2
                  ? const Color(0xFFFF6700)
                  : const Color(0xFFAEAEAE),
            ),
            label: "카테고리",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 3
                  ? const Color(0xFFFF6700)
                  : const Color(0xFFAEAEAE),
            ),
            label: "마이페이지",
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
