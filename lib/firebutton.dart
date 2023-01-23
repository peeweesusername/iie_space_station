import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/laserbolt.dart';
import 'package:iie_space_station/spacestationgame.dart';

class FireButtonSprite extends SpriteComponent with Tappable, HasGameRef {
  double radius;
  Vector2 gameSize;

  FireButtonSprite({required this.gameSize, required this.radius});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('fire_button.png');
    size = Vector2(radius,radius);
    double xpos = (size.x / 2);
    position = Vector2(xpos, gameSize.y / 2);
    anchor = Anchor.center;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    double a = (gameRef as SpaceStationGame).theStation.baseStationSprite.angle;
    double gunLen = (gameRef as SpaceStationGame).theStation.radius;
    Vector2 c = (gameRef as SpaceStationGame).theStation.center;
    LaserBolt lb = LaserBolt(
        l: laserBoltL,
        w: laserBoltW,
        a: a,
        gl: gunLen,
        originCenter: c);
    (gameRef as SpaceStationGame).add(lb);
    info.handled = true;
    return true;
  }
}
