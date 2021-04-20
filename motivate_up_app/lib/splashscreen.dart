import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivate_up_app/check.dart';
import 'package:splashscreen/splashscreen.dart';



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: new SplashScreen(
          seconds: 5,
          navigateAfterSeconds: new Check(),
          image: new Image.asset('images/logo.png'),
          photoSize: 200,
          gradientBackground: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xff03989e), Color(0xff5ce1e6)]),
          loaderColor: Colors.cyanAccent,
        ),
      ),
    );
  }


  // @override
  // initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }
  //
  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

}
