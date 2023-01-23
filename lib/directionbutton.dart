import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:iie_space_station/angles.dart';
import 'package:iie_space_station/spacestationgame.dart';

class DirectionButtonSprite extends SpriteComponent with Tappable, HasGameRef {
  double radius;
  Vector2 gameSize;

  DirectionButtonSprite({required this.gameSize, required this.radius});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('direction_button.png');
    size = Vector2(radius,radius);
    double xpos = gameSize.x - (size.x / 2);
    position = Vector2(xpos, gameSize.y / 2);
    anchor = Anchor.center;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    double x = info.eventPosition.game.x - position.x;
    double y = position.y - info.eventPosition.game.y;
    Direction_E d = determineQuadrant(x,y);
    double a = computeStationAngle(d, gameSize);
    (gameRef as SpaceStationGame).theStation.rotate2(a);
    info.handled = true;
    return true;
  }
}
