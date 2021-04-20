import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'loader.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int n = 0;

  String wishes() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning, I am Sara 💙 ';
    }
    if (hour < 16) {
      return 'Afternoon, stay motivated';
    }
    if (hour < 20) {
      return 'Evening, hope you are doing well';
    }
    return 'Night, see you tomorrow';
  }

  list() {
    var lst = new List(5);
    lst[0] =
        '🎯  Visit daily quotes for today`s motivation.   \n\n       Share it to your status & motivate others.';
    lst[1] =
        '🎯  Increase your daily, productivity.  \n\n      Add & complete tasks to maintain streak.';
    lst[2] =
        '🎯  Earn points for maintaining streaks, \n\n      completing tasks & sharing quotes.';
    lst[3] =
        '🎯  Win exciting swags, goodies and prizes,   \n\n       use points to win & unlock scratch cards.';
    lst[4] =
        '🎯  Check your profile, Earn referral coins \n\n       for sharing the app !';
    return lst[n];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xff03989e), Color(0xff5ce1e6)]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Motivate` UP ',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 40,
                            color: Color(0xff5ce1e6),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Image.asset(
                        'images/sara.png',
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Hey, ',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 20,
                              color: Color(0xffbcf8fa),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              nam,
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 25,
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Good ',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 15,
                              color: Color(0xffbcf8fa),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            wishes(),
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 15,
                              color: Color(0xffbcf8fa),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        color: Colors.black,
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                          child: Text(
                            list().toString(),
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 13,
                              color: Color(0xffbcf8fa),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RawMaterialButton(
                        fillColor: Colors.black,
                        shape: CircleBorder(),
                        onPressed: () {
                          playAudio();
                          setState(() {
                            n = n + 1;
                            if (n > 4) {
                              setState(() {
                                n = 0;
                              });
                            }
                          });
                        },
                        splashColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.fast_forward,
                            color: Colors.cyanAccent,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  playAudio() {
    print('tune playing');
    final player = AudioCache();
    player.play('magicwand.mp3');
  }
}
