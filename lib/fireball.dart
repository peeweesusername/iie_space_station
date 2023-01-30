import 'dart:math' as math;
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/alienship.dart';

class FireBall extends BodyComponent {
  double l;
  double w;
  double a;
  double gl;
  Vector2 originCenter;

  FireBall({required this.l,
    required this.w,
    required this.a,
    required this.gl,
    required this.originCenter});

  late SpriteComponent fireBallSprite;
  bool destroy = false;

  @override
  Body createBody() {
    double angle = a - (90.0*math.pi/180.0);
    Vector2 fireBallPosition = originCenter;
    //Adjust center for size of gun
    fireBallPosition += Vector2(gl*math.cos(angle), gl*math.sin(angle));

    //Add Sprite with image of laser bolt
    Image fireBallImage = Flame.images.fromCache('fireball.gif');
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
        linearVelocity: Vector2(lbSpeed*math.cos(angle), lbSpeed*math.sin(angle)),
        angle: angle,
        angularVelocity: 0,
        type: BodyType.dynamic,
        bullet: true,
        fixedRotation: true,
        userData: mycontact
    );
    //TODO: add fire ball muzzle blast sound
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (destroy) {
      world.destroyBody(body);
      removeFromParent();
      destroy = false;
      //TODO: explosion here
    }
  }

}

class FireBallCallback extends ContactCallbacks {
  final FireBall fireBall;

  FireBallCallback({required this.fireBall});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
    //fireBalls will always explode
    if (other is !AlienShipCallback) {
      fireBall.destroy = true;
    }
  }
}
