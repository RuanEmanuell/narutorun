import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

import "../controller/controller.dart";

import "game.dart";
import "options.dart";

//Importing Mobx
final data = Controller();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            //This is the main container that contains the image
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.orange,
                image: DecorationImage(
                    opacity: 0.25,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/appbackground.png"))),
            child: Column(children: [
              //Game Logo
              Container(
                  margin: EdgeInsets.only(top: screenHeight / 10),
                  width: screenWidth / 1.1,
                  height: screenHeight / 3,
                  child: Image.asset("assets/images/logo.png")),
              //Play button
              Container(
                  margin: EdgeInsets.all(10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MainGame();
                          },
                        ));
                      },
                      child: Text("Play",
                          style: GoogleFonts.permanentMarker(
                              fontSize: screenWidth / 5,
                              color: Color.fromARGB(255, 84, 175, 250),
                              shadows: [Shadow(color: Colors.black, offset: Offset(5, 5))])))),
              //Options button
              Container(
                  margin: EdgeInsets.all(10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return OptionsScreen();
                          },
                        ));
                      },
                      child: Text("Options",
                          style: GoogleFonts.permanentMarker(
                              fontSize: screenWidth / 6,
                              color: Color.fromARGB(255, 84, 175, 250),
                              shadows: [Shadow(color: Colors.black, offset: Offset(5, 5))]))))
            ])));
  }
}
