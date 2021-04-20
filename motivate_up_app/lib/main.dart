import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motivate_up_app/splashscreen.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  timeDilation = 1.5;
  runApp(new MaterialApp(
    title: "Motivate'UP",
    color: Color(0xff03989e),
    home: new MyApp(),
  ));
}

// class SlideRightRoute extends PageRouteBuilder {
//   final Widget page;
//   SlideRightRoute({this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(0, 0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           ),
//         );
// }
