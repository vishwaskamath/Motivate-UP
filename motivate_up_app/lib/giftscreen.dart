import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:motivate_up_app/signin.dart';
import 'package:scratcher/scratcher.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_beautiful_popup/main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User currentUser = _auth.currentUser;

bool firstTime = false;
var prize;
var userDocument;
final _firestore = FirebaseFirestore.instance;

class GiftScreen extends StatefulWidget {
  @override
  _GiftScreenState createState() => new _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  ConfettiController _controllerCenter;
  double _opacity = 0.0;
  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
    getCoinData();
    getPrizenumber();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  Future<void> scratchCardDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'You\'ve won a scratch card',
              style: TextStyle(
                  color: Color(0xff03989e),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            return Scratcher(
              accuracy: ScratchAccuracy.low,
              threshold: 25,
              brushSize: 50,
              onThreshold: () {
                setState(() {
                  _opacity = 1;
                });
              },
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: _opacity,
                child: Container(
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      prize[prizeNumber],
                      width: 100,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  popup() {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateRedPacket,
    );
    popup.show(
      title: 'OOP\'s 404',
      content: 'Looks like you have insufficient balance  :( \n'
          'Keep collecting coins, and come back anytime!',
      actions: [
        popup.button(
          label: 'Try Later! ',
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }

  int prizeWon = 0;
  int choice;

  void functionZero() {
    prizeWon = 10;
    setState(() {
      prizeNumber = prizeWinnerZero();
      updatePrizeData();
    });
  }

  void functionOne() {
    if (coins >= 10000) {
      playAudio();
      _controllerCenter.play();
      scratchCardDialog(context);
      Random random = new Random();
      prizeWon = random.nextInt(90)+1;
      print(prizeWon);
      setState(() {
        prizeNumber = prizeWinnerOne();
        coins = coins - 10000;
        updateData();
        getCoinData();
        updatePrizeData();
        getPrizenumber();
      });
    } else {
      popup();
      playAudioo();
    }
  }

  void functionTwo() {
    if (coins >= 30000) {
      playAudio();
      _controllerCenter.play();
      scratchCardDialog(context);
      Random random = new Random();
      prizeWon = random.nextInt(60)+1;
      setState(() {
        prizeNumber = prizeWinnerTwo();
        coins = coins - 30000;
        updateData();
        getCoinData();
        getPrizenumber();
      });
      print(prizeWon);
    } else {
      popup();
      playAudioo();
    }
  }

  void functionThree() {
    if (coins >= 90000) {
      playAudio();
      _controllerCenter.play();
      scratchCardDialog(context);
      Random random = new Random();
      prizeWon = random.nextInt(30)+1;
      setState(() {
        prizeNumber = prizeWinnerThree();
        coins = coins - 90000;
        updateData();
        getCoinData();
        getPrizenumber();
      });
      print(prizeWon);
    } else {
      popup();
      playAudioo();
    }
  }

  int prizeWinnerZero() {
    return 0;
  }

  int prizeWinnerOne() {
    switch (prizeWon) {
      case 7:
        return 1;
        break;
      case 31:
        return 2;
        break;
      case 57:
        return 3;
        break;
      default:
        return 0;
        break;
    }
  }

  int prizeWinnerTwo() {
    switch (prizeWon) {
      case 17:
        return 1;
        break;
      case 57:
        return 2;
        break;
      case 43:
        return 3;
        break;
      default:
        return 0;
        break;
    }
  }

  int prizeWinnerThree() {
    switch (prizeWon) {
      case 1:
        return 1;
        break;
      case 2:
        return 2;
        break;
      case 3:
        return 3;
        break;
      case 17:
        return 4;
        break;
      case 23:
        return 5;
        break;
      default:
        return 0;
        break;
    }
  }

  int page;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5ce1e6),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
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
                          padding: const EdgeInsets.only(
                              top: 30.0, bottom: 20, left: 20, right: 20),
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
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Unlock gift cards using your $userDocument coins 💰 ',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 15,
                              color: Color(0xffbcf8fa),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ConfettiWidget(
                          confettiController: _controllerCenter,
                          blastDirectionality: BlastDirectionality
                              .explosive, // don't specify a direction, blast randomly
                          shouldLoop:
                              true, // start again as soon as the animation is finished
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                            Colors.purple
                          ], // manually specify the colors to be used
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    'images/gift3.png',
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '10000 💰 ',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 15,
                                    color: Color(0xffbcf8fa),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FlatButton(
                                color: Colors.black,
                                splashColor: Colors.white,
                                onPressed: () {
                                  coins = userDocument;
                                  functionOne();
                                },
                                child: Text(
                                  'Claim',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 15,
                                    color: Color(0xffbcf8fa),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    'images/gift2.png',
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '30000 💰 ',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 15,
                                    color: Color(0xffbcf8fa),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FlatButton(
                                color: Colors.black,
                                splashColor: Colors.white,
                                onPressed: () {
                                  coins = userDocument;
                                  functionTwo();
                                },
                                child: Text(
                                  'Claim',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 15,
                                    color: Color(0xffbcf8fa),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    'images/gift1.png',
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '90000 💰 ',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 15,
                                    color: Color(0xffbcf8fa),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FlatButton(
                                color: Colors.black,
                                splashColor: Colors.white,
                                onPressed: () {
                                  coins = userDocument;
                                  functionThree();
                                },
                                child: Text(
                                  'Claim',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 15,
                                    color: Color(0xffbcf8fa),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  updateData() {
    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
      'Coins': coins,
    });
  }

  updatePrizeData() {
    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
      'Prize': prizeNumber,
    });
  }

  playAudio() {
    print('tune playing');
    final player = AudioCache();
    player.play('5_Sec_Crowd_Cheer-Mike_Koenig-1562033255.mp3');
  }

  playAudioo() {
    print('tune playing');
    final player = AudioCache();
    player.play('magicsmall.mp3');
  }

  void getCoinData() async {
    DocumentSnapshot user =
        await _firestore.collection("users").doc(currentUser.uid).get();

    if (user.data != null) {
      userDocument = user.data()['Coins'];
    }
  }



  void getPrizenumber() async {
    DocumentSnapshot user =
        await _firestore.collection("images").doc('byQhJY3aMbS4o98NNseU').get();

    if (user.data != null) {
      prize = user.data()['prizes'];
    }
  }
}

// Stream<Record> get() {
//   return FirebaseFirestore.instance
//       .collection("images")
//       .doc("byQhJY3aMbS4o98NNseU")
//       .get()
//       .then((snapshot) {
//     try {
//       return Record.fromSnapshot(snapshot);
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }).asStream();
// }
//
// class Record {
//   // Header members
//   String documentID;
//   List prize = new List();
//
//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : documentID = snapshot.id,
//         prize = List.from(snapshot.data()['prizes']);
// }
