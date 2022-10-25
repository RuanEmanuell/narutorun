import 'package:alarme/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "game.dart";

//Stream for showing the rankings
final Stream<QuerySnapshot> _recordsStream =
    FirebaseFirestore.instance.collection("records").snapshots();

class EndScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.black,
            child: Column(children: [
              //Return to menu button
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: screenHeight / 20),
                child: IconButton(
                    onPressed: () {
                      data.died = false;
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen();
                        },
                      ));
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: screenWidth / 7.5)),
              ),
              //Rankings text
              Container(
                margin: EdgeInsets.only(top: screenHeight / 25),
                child: Text("Rankings",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.permanentMarker(fontSize: screenWidth / 7, color: Colors.white)),
              ),
              //Actual rankings, being displayed from the firestore collection
              SizedBox(
                  height: screenHeight / 2,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _recordsStream,
                      builder: (context, snapshot) {
                        return ListView(
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          return Container(
                              child: Column(children: [
                            Text(data["record"].toString(),
                                style: GoogleFonts.permanentMarker(
                                    fontSize: screenWidth / 20, color: Colors.white))
                          ]));
                        }).toList());
                      })),
              //Replay button
              Container(
                  margin: EdgeInsets.only(top: screenHeight / 30),
                  child: IconButton(
                      onPressed: () {
                        data.died = false;
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MainGame();
                          },
                        ));
                      },
                      icon: Icon(Icons.replay, color: Colors.white, size: screenWidth / 7.5)))
            ])));
  }
}
