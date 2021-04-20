import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivate_up_app/check.dart';
import 'package:motivate_up_app/signin.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_return

    return SafeArea(
      child: new Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              new Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xff5ce1e6), Color(0xff03989e)])),
                child: Column(
                  children: <Widget>[
                    Image.asset('images/logo1.png'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'SIGN IN TO CONTINUE',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 20,
                            color: Color(0xffbcf8fa),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      // ignore: missing_return
                      onPressed: () {
                        signInWithGoogle().whenComplete(() {

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Check();
                              },
                            ),
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
                          child: ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Image.asset(
                                'images/471px-Google__G__Logo.svg.png',
                                width: 40,
                              ),
                            ),
                            title: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
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

// ignore: missing_return

}
