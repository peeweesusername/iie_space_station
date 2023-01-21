import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/contacthandlers.dart';

class BaseStation extends BodyComponent {
  double radius;
  Vector2 gameSize;

  BaseStation({required this.gameSize, required this.radius});

  late SpriteComponent baseStationSprite;

  @override
  Body createBody() {
    Vector2 baseStationPosition = Vector2(gameSize.x / 2, gameSize.y / 2);
    //Add Sprite with image of space station/gun turret
    Image baseStationImage = Flame.images.fromCache('base_station.png');
    baseStationSprite = SpriteComponent.fromImage(
        baseStationImage,
        anchor: Anchor.center,
        size: Vector2(radius*baseStationScale, radius*baseStationScale),
      );
    add(baseStationSprite);

    final shape = CircleShape();
    shape.radius = radius;
    //Attempt to create phosphor green of Apple IIe monitor
    setColor (const Color(0xFF41FF00));

    final mycontact = baseStationCallback(baseStation: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(position: baseStationPosition, linearVelocity: Vector2.zero(), type: BodyType.dynamic, userData: mycontact);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
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
