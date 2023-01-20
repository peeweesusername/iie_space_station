import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class DirectionButton extends BodyComponent with Tappable{
  double radius;
  Vector2 gameSize;

  DirectionButton({required this.gameSize, required this.radius});

  late SpriteComponent directionButtonSprite;

  @override
  Body createBody() {
        //Add Sprite with image of space direction button
    Image baseStationImage = Flame.images.fromCache('direction_button.png');
    directionButtonSprite = (SpriteComponent.fromImage(
        baseStationImage,
        anchor: Anchor.center,
        size: Vector2(radius, radius),
      )
    );

    double xpos = gameSize.x - ((directionButtonSprite.size.x) / 2);
    Vector2 directionButtonPosition = Vector2(xpos, gameSize.y / 2);

    add(directionButtonSprite);

    final shape = CircleShape();
    shape.radius = radius/2;
    setColor (const Color(0x00000000));

    final bodyDef = BodyDef(position: directionButtonPosition, linearVelocity: Vector2.zero(), type: BodyType.static);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    print ('direction button handles tapdown');
    info.handled = true;
    return true;
  }
}