import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:motivate_up_app/loader.dart';
import 'package:motivate_up_app/loginscreen.dart';

class Check extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!(FirebaseAuth.instance.currentUser == null)) {
      return Loader();
    } else
      return LoginScreen();
  }
}
