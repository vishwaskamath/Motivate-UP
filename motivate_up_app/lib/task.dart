import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motivate_up_app/signin.dart';
import 'loader.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User currentUser = _auth.currentUser;
var userDoc;

final _firestore = FirebaseFirestore.instance;

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => new _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int task = 0;
  bool added = false;
  var buttonColor = Colors.red;
  String message = ' No Tasks Added ';
  String messageText;
  final messageTextController = TextEditingController();
  int page;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5ce1e6),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
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
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            'Motivate` UP ',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Image.asset(
                          imageReturn(),
                          width: 220,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0, right: 0.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  ' ➵ Hey , ',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Add a task to complete📝',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  ' ➵ Your daily streak is 🔥 : ',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  userDoc.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 50.0, right: 50.0),
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: messageTextController,
                              onChanged: (value) {
                                messageText = value;
                              },
                              cursorColor: Colors.white,
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        splashColor: Colors.white70,
                        color: Color(0xff03989e),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (added == false) {
                              setState(() {
                                task = 1;
                                playAudio();
                                buttonColor = Colors.red;
                                message = messageText;
                                added = true;
                              });
                            }

                            messageTextController.clear();
                            _firestore.collection('tasks').add({
                              'text': messageText,
                              'sender': mUser.email,
                            });
                          }
                        },
                        child: Text(
                          'ADD',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: Text(
                          '➵ Your current task ( Tap once Finished ! ) : ',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 13.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        splashColor: Colors.white70,
                        color: Colors.black,
                        onPressed: () {
                          if (added == true) {
                            setState(() {
                              task = 2;
                              added = false;
                              playAudiow();
                              coins = coins + 100;
                              buttonColor = Colors.green;
                              message = ' Task completed 🤩 ';
                            });
                          }
                        },
                        child: Text(
                          message.toString(),
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 22,
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
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

  playAudio() {
    final player = AudioCache();
    player.play('magicsmall.mp3');
  }

  playAudiow() {
    print('tune playing');
    final player = AudioCache();
    player.play('magicsmall.mp3');
  }

  @override
  void initState() {

    super.initState();
    getStreakData();
  }




  void getStreakData() async {
    DocumentSnapshot user =
        await _firestore.collection("users").doc(currentUser.uid).get();

    if (user.data != null) {
      userDoc = user.data()['Streak'];
    } else {
      return null;
    }
  }

  String imageReturn() {
    if (task == 0) {
      return 'images/cat2.png';
    }
    if (task == 1) {
      return 'images/cat1.png';
    }
    if (task == 2) {
      return 'images/cat2.png';
    } else {
      return 'images/cat2.png';
    }
  }
}
