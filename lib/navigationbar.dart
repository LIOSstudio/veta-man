import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'schedule.dart';
import 'Mypage.dart';
import 'chart.dart';
import 'goal/py1.dart';

class NavigationPage extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationPage> {
  var _currentIndex = 0;

  final List<Widget> _children = [
    nameinput(),
    Timetable(),
    ChartPage(),
    MyPage(),
  ];
  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Motive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: SalomonBottomBar(

            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home,
                  size: 24,),
                title: Text("Home"),
                selectedColor: Colors.purple,

              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.calendar_today,size: 24),
                title: Text("TimeTable"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(Icons.leaderboard,size: 24),
                title: Text("Statistics"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person,size: 24),
                title: Text("Profile"),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),

      ),
    );
  }
}