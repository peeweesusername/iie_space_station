import 'package:flutter/material.dart' hide Transform;
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/contacthandlers.dart';
import 'package:iie_space_station/spacestationgame.dart';

class BaseStation extends BodyComponent {
  Vector2 position;
  double size;
  Vector2 linearVelocity;

  late SpaceStationGame parentGame = findParent() as SpaceStationGame;

  BaseStation({required this.position, required this.size, required this.linearVelocity});

  @override
  Body createBody() {
    //setColor(Colors.green);
    //Attempt to create phosphor green of Apple IIe monitor
    setColor (const Color(0xFF41FF00));

    final shape = PolygonShape();
    //Make box rotated 45 degrees
    shape.setAsBox(size, size, Vector2.zero(), 45.0);
    final mycontact = baseStationCallback(baseStation: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(position: position, linearVelocity: linearVelocity, type: BodyType.dynamic, userData: mycontact);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

}
