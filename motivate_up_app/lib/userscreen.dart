import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => new _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int page;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
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
                      height: 30,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                ' 🎯 Stay Motivated! 🎯 ',
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: 25,
                                  color: Color(0xffbcf8fa),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          child: Image.asset(
                            'images/sara.png',
                            height: 200,
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                '➵ Share to earn coins!',
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: 15,
                                  color: Color(0xffbcf8fa),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RawMaterialButton(
                              fillColor: Colors.black,
                              shape: CircleBorder(),
                              splashColor: Colors.white70,
                              onPressed: (){},
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.cyanAccent,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                '➵ Rate us on Play store!',
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: 15,
                                  color: Color(0xffbcf8fa),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RawMaterialButton(
                              fillColor: Colors.black,
                              shape: CircleBorder(),
                              splashColor: Colors.white70,
                              onPressed: (){},
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.shop,
                                    color: Colors.cyanAccent,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Text(
                            'CREDITS',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 15,
                              color: Color(0xffbcf8fa),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            'V 1 . 0 . 0',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 15,
                              color: Color(0xffbcf8fa),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
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
}
