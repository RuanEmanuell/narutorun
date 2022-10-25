import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import "package:flame/game.dart";
import "package:flame/input.dart";

import 'package:firebase_core/firebase_core.dart';
import "package:cloud_firestore/cloud_firestore.dart";

import "home.dart";
import "end.dart";
import "../controller/controller.dart";


//Global game variables
bool isSubstitution = false;
int isKurama = 0;
bool tappable = true;
bool canDie = true;

//Collection for creating the rankings in Firestore
final CollectionReference records = FirebaseFirestore.instance.collection("records");

class MainGame extends StatefulWidget {
  @override
  State<MainGame> createState() => _MainGameState();
}

class _MainGameState extends State<MainGame> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: data.died ? EndScreen() : Stack(children: [
              //GameWidget
              SizedBox(height: screenHeight, child: GameWidget(game: GameScreen(setState:setState))),
              //Naruto Kurama power button
              Container(
                margin: EdgeInsets.only(top: screenHeight / 1.25),
                height: screenHeight / 3,
                child: TextButton(
                    child: Image.asset("assets/images/power2.png"),
                    onPressed: () {
                      //isKurama == 0 represents not using the power but you can use
                      //1 represents using and 2 represents not using and you can't use
                      if (isKurama == 0) {
                        isKurama = 1;
                        canDie = false;
                        Future.delayed(Duration(seconds: 5), () {
                          isKurama = 2;
                        });
                        Future.delayed(Duration(seconds: 7), () {
                          canDie = true;
                        });
                        Future.delayed(Duration(seconds: 15), () {
                          isKurama = 0;
                        });
                      }
                    }),
              ),
              //Substituion button
              Container(
                margin: EdgeInsets.only(top: screenHeight / 1.25, left: screenWidth / 1.5),
                height: screenHeight / 3,
                child: TextButton(
                    child: Image.asset("assets/images/power1.png"),
                    onPressed: () {
                      if (tappable && isKurama != 1) {
                        isSubstitution = true;
                        tappable = false;
                        canDie = false;
                        Future.delayed(Duration(milliseconds: 2000), () {
                          isSubstitution = false;
                        });
                        Future.delayed(Duration(milliseconds: 2100), () {
                          tappable = true;
                          canDie = true;
                        });
                      }
                    }),
              ),
            ])
    );
  }
}

class GameScreen extends FlameGame with TapDetector, HasCollisionDetection {

  //Adding required variables

  var setState;

  GameScreen({required this.setState});

  var background1;
  var background2;
  var naruto;
  var narutoAnimation1;
  var narutoAnimation2;
  var narutoAnimation3;
  var spriteSheet1;
  var spriteSheet2;
  var spriteSheet3;
  var obstacle1;
  var obstacle2;
  var obstacleSpriteSheet;
  var obstacleAnimation;

  var random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    //Loading sprites
    background2 = await ParallaxComponent.load([ParallaxImageData("background2.png")],
        baseVelocity: Vector2(0, 10),
        velocityMultiplierDelta: Vector2.all(10),
        repeat: ImageRepeat.repeat,
        size: size);

    add(background2);

    background1 = await ParallaxComponent.load([ParallaxImageData("background1.png")],
        baseVelocity: Vector2(0, 5),
        velocityMultiplierDelta: Vector2.all(10),
        repeat: ImageRepeat.repeat,
        size: size);
    add(background1);

    spriteSheet1 = SpriteSheet(image: await images.load("naruto1.png"), srcSize: Vector2(79, 128));
    spriteSheet2 = SpriteSheet(image: await images.load("naruto2.png"), srcSize: Vector2(83, 128));
    spriteSheet3 = SpriteSheet(image: await images.load("log.png"), srcSize: Vector2(236, 256));

    narutoAnimation1 = spriteSheet1.createAnimation(row: 0, stepTime: 0.15, to: 6);
    narutoAnimation2 = spriteSheet2.createAnimation(row: 0, stepTime: 0.13, to: 5);
    narutoAnimation3 = spriteSheet3.createAnimation(row: 0, stepTime: 0.5, to: 2);

    naruto = Naruto()
      ..animation = narutoAnimation2
      ..position = Vector2(size[0] / 3.5, size[1] / 1.3)
      ..size = Vector2(size[0] / 4, size[1] / 5);

    add(naruto);

    obstacle1 = Obstacle1()
      ..sprite = await loadSprite("obstacle1.png")
      ..position = Vector2(size[0] / 3.2, size[1])
      ..size = Vector2(size[0] / 5, size[1] / 7);

    add(obstacle1);

    obstacleSpriteSheet =
        SpriteSheet(image: await images.load("obstacle2.png"), srcSize: Vector2(225, 256));

    obstacleAnimation = obstacleSpriteSheet.createAnimation(row: 0, stepTime: 0.15, to: 2);

    obstacle2 = Obstacle2()
      ..animation = obstacleAnimation
      ..position = Vector2(size[0] / 3.2, size[1])
      ..size = Vector2(size[0] / 6, size[1] / 8);

    add(obstacle2);
  }

  @override
  void update(dt) {
    super.update(dt);
    if (!data.died) {
      //Moving the obstacles
      obstacle1.y = obstacle1.y + 5;
      obstacle2.y = obstacle2.y + 7;

      //Respawing the obstacles and increasing score
      if (obstacle1.y > size[1]) {
        data.score++;
        obstacle1.y = -size[1] / 2;
      }
      if (obstacle2.y > size[1]) {
        data.score++;
        obstacle2.y = -size[1] / 3;
      }

      //Defining which animation are going to be showed
      if (isSubstitution) {
        naruto.animation = narutoAnimation3;
      } else if (isKurama == 1) {
        naruto.animation = narutoAnimation2;
      } else {
        naruto.animation = narutoAnimation1;
      }
    }else{
      if(data.score>0){
      //Setting the record document on firestore
      records
      .doc(DateTime.now().toString())
      .set({
        "record":data.score
      });
      data.score=0;
      }

      setState((){
        data.died=true;
      });
    }
  }
}

//Collisions

class Naruto extends SpriteAnimationComponent with CollisionCallbacks {

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent naruto) {
    super.onCollision(intersectionPoints, naruto);
    if (canDie) {
      data.died = true;
    }
  }
}

class Obstacle1 extends SpriteComponent with CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent obstacle1) {
    super.onCollision(intersectionPoints, obstacle1);
  }
}

class Obstacle2 extends SpriteAnimationComponent with CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent obstacle2) {
    super.onCollision(intersectionPoints, obstacle2);
  }
}
