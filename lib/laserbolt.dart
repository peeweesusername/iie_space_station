import 'dart:math' as math;
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/basestation.dart';
import 'package:iie_space_station/fireball.dart';
import 'package:iie_space_station/explosions.dart';

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
  bool destroy = false;
  bool explode = false;

  @override
  Body createBody() {
    double angle = a - (90.0*math.pi/180.0);
    Vector2 laserBoltPosition = originCenter;
    //Adjust center for size of gun
    laserBoltPosition += Vector2(gl*math.cos(angle), gl*math.sin(angle));

    //Add Sprite with image of laser bolt
    Image laserBoltImage = Flame.images.fromCache('green_laser_bolt.png');
    laserBoltSprite = SpriteComponent.fromImage(
        laserBoltImage,
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
        linearVelocity: Vector2(glbSpeed*math.cos(angle), glbSpeed*math.sin(angle)),
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

  @override
  void update(double dt) {
    super.update(dt);
    if (explode) {
      gameRef.add(MissileExplosion(explosionPosition: body.position));
      world.destroyBody(body);
      removeFromParent();
      destroy = false;
    }
    else if (destroy) {
      world.destroyBody(body);
      removeFromParent();
      destroy = false;
    }
  }

}

class LaserBoltCallback extends ContactCallbacks {
  final LaserBolt laserBolt;

  LaserBoltCallback({required this.laserBolt});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
    //Laserbolts will always be destroyed upon contact
    //Will explode upon contact with FireBallCallback
    if (other is FireBallCallback) {
      laserBolt.explode = true;
    }
    else if (other is !BaseStationCallback) {
      laserBolt.destroy = true;
    }
  }
}
