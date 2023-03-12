import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:iie_space_station/globals.dart';

class BaseStationExplosion extends SpriteAnimationComponent with HasGameRef {

  Vector2 explosionPosition;

  BaseStationExplosion({required this.explosionPosition});

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: Flame.images.fromCache('explosion1.png'),
      srcSize: Vector2(192.0, 192),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 20, loop: false);
    position = explosionPosition;
    size = gameRef.size;
    size.multiply(baseStationExplostionSF);
    anchor = Anchor.center;
    removeOnFinish = true;
  }
}