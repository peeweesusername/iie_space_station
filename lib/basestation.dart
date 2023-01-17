import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/contacthandlers.dart';
import 'package:iie_space_station/spacestationgame.dart';

class BaseStation extends BodyComponent {
  Vector2 position;
  double radius;
  Vector2 linearVelocity;

  late SpaceStationGame parentGame = findParent() as SpaceStationGame;

  BaseStation({required this.position, required this.radius, required this.linearVelocity});

  @override
  Body createBody() {
    setColor(Colors.green);

    final shape = CircleShape()..radius = radius;
    final mycontact = baseStationCallback(baseStation: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(position: position, linearVelocity: linearVelocity, type: BodyType.dynamic, userData: mycontact);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

}
