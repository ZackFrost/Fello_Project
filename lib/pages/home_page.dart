///Created by Ian Paul on 1-08-2021 19:35
import 'package:fello_demo_app/pages/game_page.dart';
import 'package:fello_demo_app/pages/news_page.dart';
import 'package:fello_demo_app/utils/color_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _pageList = [];

  @override
  void initState() {
    _pageList = [GamePage(), NewsPage()];
    super.initState();
  }

  void onPageClicked(int newIndex) {
    if (_selectedIndex != newIndex)
      setState(() {
        _selectedIndex = newIndex;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pageList[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: COOL_PURPLE,
          items: [
            BottomNavigationBarItem(label: "GAME", icon: Icon(Icons.gamepad_outlined), activeIcon: Icon(Icons.gamepad)),
            BottomNavigationBarItem(label: "NEWS", icon: Icon(Icons.article_outlined), activeIcon: Icon(Icons.article)),
          ],
          onTap: onPageClicked,
        ),
      ),
    );
  }
}
