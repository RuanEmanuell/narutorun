import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import "package:flame/game.dart";
import "package:flame/input.dart";

class GameScreen extends FlameGame with TapDetector, HasCollisionDetection{

  var background1;
  var background2;
  var naruto1;
  var naruto2;
  var narutoAnimation1;
  var narutoAnimation2;
  var spriteSheet1;
  var spriteSheet2;

  @override
  Future<void>onLoad() async{
    super.onLoad();

   background2=await ParallaxComponent.load([
    ParallaxImageData("background2.png")
   ],
   baseVelocity: Vector2(0, 5),
   velocityMultiplierDelta: Vector2.all(10),
   repeat: ImageRepeat.repeat,
   size:size
   );


   add(background2);

   background1=await ParallaxComponent.load([
    ParallaxImageData("background1.png")
   ],
   baseVelocity: Vector2(0, 1),
   velocityMultiplierDelta: Vector2.all(10),
   repeat: ImageRepeat.repeat,
   size:size
   );
   add(background1);


  spriteSheet1=SpriteSheet(image:await images.load("naruto1.png"), srcSize:Vector2(79.5, 128));

  narutoAnimation1=spriteSheet1.createAnimation(row:0, stepTime:0.13, to:6);

  naruto1=SpriteAnimationComponent()
  ..animation=narutoAnimation1
  ..position=Vector2(size[0]/3, size[1]/1.3)
  ..size=Vector2(size[0]/4, size[1]/5);

  add(naruto1);

  }

  @override
  void update(dt){
    super.update(dt);
  }
}


class Naruto1 extends SpriteAnimationComponent with CollisionCallbacks{
  @override
  Future<void>onLoad() async{
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent naruto1){
    super.onCollision(intersectionPoints, naruto1);

  }
}