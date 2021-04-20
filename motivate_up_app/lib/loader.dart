import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:motivate_up_app/example.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'giftscreen.dart';

final assetsAudioPlayer = AssetsAudioPlayer();



final _firestore = FirebaseFirestore.instance;

String nam;
User mUser;
FirebaseAuth _auth;
int i, j = 0;
int newDay = 0;
var currentNext = 0;
DateTime first;
bool visitedToday = false;
String prev;
int streak = 0;
String value;
int coinsValue;

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => new _LoaderState();
}

class _LoaderState extends State<Loader> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        print('paused');
        assetsAudioPlayer.pause();
        break;
      case AppLifecycleState.resumed:
        print('resumed');
        assetsAudioPlayer.play();
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        assetsAudioPlayer.pause();
        break;
      case AppLifecycleState.detached:
        print('detached');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 1000,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xff03989e), Color(0xff5ce1e6)]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.asset('images/logo1.png'),
                    HeartbeatProgressIndicator(
                      child: Icon(
                        Icons.all_inclusive,
                        color: Color(0xff78ebef),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xff78ebef),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'START',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Orbitron',
                            fontSize: 25,
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                      onPressed: () {
                        visitedToday = true;
                        checkingVisit();

                        playAudio();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return MyHomePage();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'images/whiterooloo.png',
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  playAudio() {
    print('bg music playing');
    AssetsAudioPlayer.playAndForget(Audio("assets/saravoice.mp3"));
    assetsAudioPlayer.open(
      Audio("assets/ufolong.mp3"),
      volume: 0.3,
      loopMode: LoopMode.single,
    );
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('Value', prev);
    });
  }

  checkingVisit() {
    if (visitedToday == true) {
      DateTime visit = DateTime.now();
      String convertedVisit =
          "${visit.year.toString()}-${visit.month.toString().padLeft(2, '0')}-${visit.day.toString().padLeft(2, '0')}";
      valueGet();
      if (value != null) {
        final disco = DateTime.parse(prev);
        final atta = visit.difference(disco).inDays;
        print(" value of ass is");
        print(atta);
        if (atta == 1) {
          setState(() {
            streak++;
            print("streak is");
            print(streak);
            updateDataa();
          });
        }
        if (atta > 1) {
          setState(() {
            streak = 0;
            updateDataa();
          });
        }
      }
      setState(() {
        prev = convertedVisit;
        print(" value of converted");
        print(prev);
        addIntToSF();
      });
    }
  }


  updateDataa() {
    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
      'Streak': streak,
    });
  }

  valueGet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    setState(() {
      value = prefs.getString('Value');
      print(" value of local");
      print(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();

    print('here outside async');
    WidgetsBinding.instance.addObserver(this);
  }

  _getCurrentUser() {
    DateTime now = DateTime.now();
    final date = _auth.currentUser.metadata.creationTime;
    String convertedDateToday =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    String convertedDateLogin =
        "${now.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final todayDate = DateTime.parse(convertedDateToday);
    final userDate = DateTime.parse(convertedDateLogin);

    mUser = _auth.currentUser;
    print('Hello ' + mUser.displayName.toString());
    setState(() {
      nam = mUser.displayName.toString();
      i = todayDate.difference(userDate).inDays;
      if (i > j) {
        setState(() {
          newDay = 1;
        });
      }
      j = i;
    });
    print("difference in date is");
    print(i);
  }
}
