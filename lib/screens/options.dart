import 'package:alarme/screens/home.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "home.dart";

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            //Container containing the background image
            padding: EdgeInsets.only(top: screenWidth / 10),
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 84, 175, 250),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: 0.3,
                    image: AssetImage("assets/images/appbackground2.png"))),
            child: Column(children: [
              //Return button
              Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ));
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.orange, size: screenWidth / 7.5))),
              //Disable and Enable music button, still not finished
              Container(
                  margin: EdgeInsets.only(top: screenWidth / 10),
                  child: TextButton(
                      onPressed: () {},
                      child: Text("Music",
                          style: GoogleFonts.permanentMarker(
                              fontSize: screenWidth / 5,
                              color: Color.fromARGB(255, 255, 145, 0),
                              shadows: [Shadow(color: Colors.black, offset: Offset(5, 5))])))),
              //Switch account button, still not finished     
              Container(
                  margin: EdgeInsets.only(top: screenWidth / 10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return OptionsScreen();
                          },
                        ));
                      },
                      child: Text("Account",
                          style: GoogleFonts.permanentMarker(
                              fontSize: screenWidth / 6,
                              color: Color.fromARGB(255, 255, 145, 0),
                              shadows: [Shadow(color: Colors.black, offset: Offset(5, 5))])))),
              //Credits button, still not finished                      
              Container(
                  margin: EdgeInsets.only(top: screenWidth / 10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return OptionsScreen();
                          },
                        ));
                      },
                      child: Text("Credits",
                          style: GoogleFonts.permanentMarker(
                              fontSize: screenWidth / 6,
                              color: Color.fromARGB(255, 255, 145, 0),
                              shadows: [Shadow(color: Colors.black, offset: Offset(5, 5))]))))
            ])));
  }
}
