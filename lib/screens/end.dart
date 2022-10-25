import 'package:alarme/screens/home.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "game.dart";
import "home.dart";

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
              Container(
                margin: EdgeInsets.only(top: screenHeight / 12),
                child: Text("Rankings",
                    style: GoogleFonts.permanentMarker(fontSize: screenWidth / 7, color: Colors.white)),
              ),
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
                      icon: Icon(Icons.replay, color: Colors.white, size: screenWidth / 5)))
            ])));
  }
}
