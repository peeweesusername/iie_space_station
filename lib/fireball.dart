import 'dart:math' as math;
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/spacestationgame.dart';
import 'package:iie_space_station/laserbolt.dart';

class FireBall extends BodyComponent {
  double l;
  double w;
  double a;
  double gl;
  double speed;
  Vector2 originCenter;

  FireBall({required this.l,
    required this.w,
    required this.a,
    required this.gl,
    required this.speed,
    required this.originCenter});

  late SpriteComponent fireBallSprite;
  bool destroy = false;

  @override
  Body createBody() {
    double angle = a + (90.0*math.pi/180.0);
    Vector2 fireBallPosition = originCenter;
    //Adjust center for size of gun
    fireBallPosition += Vector2(gl*math.cos(angle), gl*math.sin(angle));

    //Add Sprite with image of laser bolt
    Image fireBallImage = Flame.images.fromCache('fireball.png');
    fireBallSprite = SpriteComponent.fromImage(
        fireBallImage,
        anchor: Anchor.center,
        size: Vector2(l, w)
    );
    add(fireBallSprite);

    final shape = CircleShape();
    shape.radius = fireBallR;
    setColor (const Color(0x00000000));

    final mycontact = FireBallCallback(fireBall: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(
        position: fireBallPosition,
        linearVelocity: Vector2(speed*math.cos(angle), speed*math.sin(angle)),
        angle: angle,
        angularVelocity: 0,
        type: BodyType.dynamic,
        fixedRotation: true,
        userData: mycontact
    );
    FlameAudio.play('blaster.mp3');
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (destroy) {
      world.destroyBody(body);
      removeFromParent();
      destroy = false;
    }
  }

}

class FireBallCallback extends ContactCallbacks {
  final FireBall fireBall;

  FireBallCallback({required this.fireBall});

  late SpaceStationGame parentGame = fireBall.findParent() as SpaceStationGame;

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
    if (other is LaserBoltCallback) {
      fireBall.destroy = true;
      parentGame.score += 1;
    }
  }
}
