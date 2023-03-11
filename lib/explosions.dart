
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class BaseStationExplosion extends SpriteAnimationComponent with HasGameRef {

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: Flame.images.fromCache('explosion1.png'),
      srcSize: Vector2(192.0, 192),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 20, loop: false);
    position = gameRef.size/2;
    size = Vector2(32,32);
    anchor = Anchor.center;
    removeOnFinish = true;
  }
}