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
  late Vector2 directionButtonPosition;

  @override
  Body createBody() {
    //Add Sprite with image of space direction button
    Image baseStationImage = Flame.images.fromCache('direction_button.png');
    directionButtonSprite = SpriteComponent.fromImage(
        baseStationImage,
        anchor: Anchor.center,
        size: Vector2(radius, radius),
      );

    double xpos = gameSize.x - ((directionButtonSprite.size.x) / 2);
    directionButtonPosition = Vector2(xpos, gameSize.y / 2);
    print(directionButtonPosition.toString());

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
    double x = info.eventPosition.game.x - directionButtonPosition.x;
    double y = directionButtonPosition.y - info.eventPosition.game.y;
    print ('direction button handles tapdown');
    print (x);
    print (y);
    /*
      X & Y > 0: NE
      X > 0, Y < 0: SE
      X & Y < 0 : SW
      X < 0, Y > 0: NW
    */
    info.handled = true;
    return true;
  }
}

//This no worky
class DirectionButtonSprite extends SpriteComponent with HasGameRef {
  double radius;
  Vector2 gameSize;

  DirectionButtonSprite({required this.gameSize, required this.radius});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final Image baseStationImage = Flame.images.fromCache('direction_button.png');
    //sprite = await gameRef.loadSprite('direction_button.png');
    sprite = Sprite(baseStationImage);
    //position = Vector2(gameSize.x / 2, gameSize.y / 2);
    position = Vector2(gameRef.size.x/2, gameRef.size.y/2);
    anchor = Anchor.center;
    print("loading direction button");
    print(sprite.toString());
  }
}