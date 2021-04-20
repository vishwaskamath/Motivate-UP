import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motivate_up_app/signin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:modified_share/modified_share.dart';
import 'loader.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User currentUser = _auth.currentUser;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              SizedBox(
                height: 550,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            ' 🎯 Today`s Motivation 🎯 ',
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
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: StreamBuilder<Record>(
                        stream: get(),
                        // ignore: missing_return
                        builder: (BuildContext c, AsyncSnapshot<Record> data) {
                          if (data?.data == null)
                            return HeartbeatProgressIndicator(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Icon(
                                  Icons.cached,
                                  color: Color(0xff78ebef),
                                  size: 35.0,
                                ),
                              ),
                            );
                          Record r = data.data;
                          return Column(
                            children: <Widget>[
                              Image.network(
                                r.quote[i],
                                width: 300,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(
                                  'Share if you liked it!',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 20,
                                    color: Color(0xffbcf8fa),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RawMaterialButton(
                                fillColor: Colors.black,
                                shape: CircleBorder(),
                                splashColor: Colors.white70,
                                onPressed: () async {
                                  coins = coins + 100;
                                  updateData();
                                  playAudio();
                                  String imageURL = r.quote[i],
                                      content =
                                          "Install Motivate'UP today!, visit http://www.motivateup.com";
                                  Map<String, String> shareMessageDetails = {
                                    "imageURL": imageURL,
                                    "content": content,
                                  };

                                  await ModifiedShare.share(
                                      shareMessageDetails);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.cyanAccent,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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

  // playAudio(){
  //   final player = AudioCache();
  //   player.play('magicwand.mp3');
  // }



  updateData(){
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update({
      'Coins': coins,
    });
  }

  playAudio() {
    print('tune playing');
    final player = AudioCache();
    player.play('magicwand.mp3');
  }

  @override
  void initState() {

    askPermission();

    super.initState();
  }

  askPermission() async {

    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[
          Permission.storage]); // it should print PermissionStatus.granted
    }
  }


}

Stream<Record> get() {
  return FirebaseFirestore.instance
      .collection("images")
      .doc("KKcOARi6MWlSW1d57gqu")
      .get()
      .then((snapshot) {
    try {
      return Record.fromSnapshot(snapshot);
    } catch (e) {
      print(e);
      return null;
    }
  }).asStream();
}

class Record {
  // Header members
  String documentID;
  List quote = new List();

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.id,
        quote = List.from(snapshot.data()['quotes']);
}
