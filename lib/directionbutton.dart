import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class DirectionButton extends BodyComponent {
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
    final bodyDef = BodyDef(position: directionButtonPosition, linearVelocity: Vector2.zero(), type: BodyType.static);
    return world.createBody(bodyDef);
  }
}