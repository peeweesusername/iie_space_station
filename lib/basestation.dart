import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/contacthandlers.dart';
import 'package:iie_space_station/spacestationgame.dart';

class BaseStation extends BodyComponent {
  double radius;
  Vector2 position;
  Vector2 linearVelocity;

  BaseStation({required this.position, required this.radius, required this.linearVelocity});

  late SpaceStationGame parentGame = findParent() as SpaceStationGame;
  late SpriteComponent baseStationSprite;

  @override
  Body createBody() {
    //Add Sprite with image of space station/gun turret
    Image baseStationImage = Flame.images.fromCache('base_station.png');
    baseStationSprite = (SpriteComponent.fromImage(
      baseStationImage,
      anchor: Anchor.center,
      size: Vector2(radius*turretScale, radius*turretScale),
      )
    );
    add(baseStationSprite);

    final shape = CircleShape();
    shape.radius = radius;
    //Attempt to create phosphor green of Apple IIe monitor
    setColor (const Color(0xFF41FF00));
    final mycontact = baseStationCallback(baseStation: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(position: position, linearVelocity: linearVelocity, type: BodyType.dynamic, userData: mycontact);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  void rotate(double angle) {
    baseStationSprite.angle += angle*math.pi/180.0;
  }
}
