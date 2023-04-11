import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/spacestationgame.dart';
import 'package:iie_space_station/fireball.dart';
import 'package:iie_space_station/explosions.dart';

class BaseStation extends BodyComponent {
  double radius;
  Vector2 gameSize;

  BaseStation({required this.gameSize, required this.radius});

  late SpriteComponent baseStationSprite;
  late Vector2 baseStationPosition;
  bool destroy = false;

  @override
  Body createBody() {
    baseStationPosition = gameSize/2;
    //Add Sprite with image of space station/gun turret
    Image baseStationImage = Flame.images.fromCache('base_station.png');
    baseStationSprite = SpriteComponent.fromImage(
        baseStationImage,
        anchor: Anchor.center,
        size: Vector2(radius*gbaseStationScale, radius*gbaseStationScale),
      );
    add(baseStationSprite);

    final shape = CircleShape();
    shape.radius = radius;
    //Attempt to create phosphor green of Apple IIe monitor
    setColor (const Color(0xFF41FF00));

    final mycontact = BaseStationCallback(baseStation: this);
    final fixtureDef = FixtureDef(
        shape,
        density: 1.0,
        restitution: 0.0,
        friction: 1.0);
    final bodyDef = BodyDef(
        position: baseStationPosition,
        linearVelocity: Vector2.zero(),
        type: BodyType.static,
        userData: mycontact);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (destroy) {
      destroy = false;
      world.destroyBody(body);
      removeFromParent();
      gameRef.add(BaseStationExplosion(explosionPosition: baseStationPosition));
      (gameRef as SpaceStationGame).gameOver();
    }
  }

  //Argument angle is in radians
  void rotateby(double angle) {
    baseStationSprite.angle += angle;
  }

  //Argument angle is in radians
  void rotate2(double angle) {
    baseStationSprite.angle = angle;
  }
}

class BaseStationCallback extends ContactCallbacks {
  final BaseStation baseStation;

  BaseStationCallback({required this.baseStation});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
    if (other is FireBallCallback) {
      baseStation.destroy = true;
    }
  }
}
