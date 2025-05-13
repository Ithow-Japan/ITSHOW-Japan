import 'package:flutter/material.dart';
import 'package:harugo/screens/categoryScreen.dart';
import 'package:harugo/screens/homeScreen.dart';
import 'package:harugo/screens/quizStartScreen.dart';
import 'package:harugo/screens/quizresult.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavStateScreen());
  }
}

class NavStateScreen extends StatefulWidget {
  const NavStateScreen({super.key});

  @override
  State<NavStateScreen> createState() => _NavStateScreen();
}

class _NavStateScreen extends State<NavStateScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Homescreen(),
    CategoryScreen(),
    QuizStartScreen(),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xffFD6929),
        unselectedItemColor: Color(0xffAEAEAE),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: '카테고리'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: '퀴즈')
        ],
      ),
    );
  }
}
