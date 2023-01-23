import 'dart:math' as math;
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/spacestationgame.dart';
import 'package:iie_space_station/basestation.dart';

class LaserBolt extends BodyComponent {
  double l;
  double w;
  double a;
  double gl;
  Vector2 originCenter;

  LaserBolt({required this.l,
    required this.w,
    required this.a,
    required this.gl,
    required this.originCenter});

  late SpriteComponent laserBoltSprite;

  @override
  Body createBody() {
    double angle = a - (90.0*math.pi/180.0);
    Vector2 laserBoltPosition = originCenter;
    //Adjust center for size of gun
    laserBoltPosition += Vector2(gl*math.cos(angle), gl*math.sin(angle));

    //Add Sprite with image of laser bolt
    Image baseStationImage = Flame.images.fromCache('green_laser_bolt.png');
    laserBoltSprite = SpriteComponent.fromImage(
      baseStationImage,
      anchor: Anchor.center,
      size: Vector2(l, w)
    );
    add(laserBoltSprite);

    final shape = PolygonShape();
    shape.setAsBoxXY(l, w);
    setColor (const Color(0x00000000));

    final mycontact = LaserBoltCallback(laserBolt: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(
        position: laserBoltPosition,
        linearVelocity: Vector2(lbSpeed*math.cos(angle), lbSpeed*math.sin(angle)),
        angle: angle,
        angularVelocity: 0,
        type: BodyType.dynamic,
        bullet: true,
        fixedRotation: true,
        userData: mycontact
    );
    FlameAudio.play('laser_bolt.mp3');
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class LaserBoltCallback extends ContactCallbacks {
  final LaserBolt laserBolt;
  late SpaceStationGame parentGame = laserBolt.findParent() as SpaceStationGame;

  LaserBoltCallback({required this.laserBolt});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
    //Laserbolts will alway be removed upon contact
    //Other objects will explode, etc
    if (other is !BaseStationCallback) {
      parentGame.remove(laserBolt);
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    super.beginContact(other, contact);
  }
}
