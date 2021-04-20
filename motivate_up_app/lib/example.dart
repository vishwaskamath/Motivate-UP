import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivate_up_app/giftscreen.dart';
import 'package:motivate_up_app/homescreen.dart';
import 'package:motivate_up_app/mainscreen.dart';
import 'package:motivate_up_app/task.dart';
import 'package:motivate_up_app/userscreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff03989e), Color(0xff5ce1e6)]),
              ),
              child: HomeScreen(),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff03989e), Color(0xff5ce1e6)]),
              ),
              child: MainScreen(),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff03989e), Color(0xff5ce1e6)]),
              ),
              child: TaskScreen(),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff03989e), Color(0xff5ce1e6)]),
              ),
              child: GiftScreen(),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff03989e), Color(0xff5ce1e6)]),
              ),
              child: UserScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xff03989e),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: Colors.cyanAccent,
              title: Text('Sara Talks'),
              icon: Icon(
                Icons.home,
                color: Colors.cyanAccent,
              )),
          BottomNavyBarItem(
              activeColor: Colors.cyanAccent,
              title: Text('Daily Quotes'),
              icon: Icon(
                Icons.format_quote,
                color: Colors.cyanAccent,
              )),
          BottomNavyBarItem(
              activeColor: Colors.cyanAccent,
              title: Text('Let`s Work'),
              icon: Icon(
                Icons.timer,
                color: Colors.cyanAccent,
              )),
          BottomNavyBarItem(
              activeColor: Colors.cyanAccent,
              title: Text('Win Prizes'),
              icon: Icon(
                Icons.card_giftcard,
                color: Colors.cyanAccent,
              )),
          BottomNavyBarItem(
              activeColor: Colors.cyanAccent,
              title: Text('User Profile'),
              icon: Icon(
                Icons.person,
                color: Colors.cyanAccent,
              )),
        ],
      ),
    );
  }
}
