import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import "../controller/controller.dart";

import "game.dart";

final data = Controller();

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainGame();
  }
}
