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
      srcSize: Vector2(192, 192),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 20, loop: false);
    position = explosionPosition;
    size = gameRef.size;
    size.multiply(baseStationExplosionSF);
    anchor = Anchor.center;
    removeOnFinish = true;
    FlameAudio.play('explosion1.mp3');
  }
}

class AlienShipExplosion extends SpriteAnimationComponent with HasGameRef {

  Vector2 explosionPosition;

  AlienShipExplosion({required this.explosionPosition});

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: Flame.images.fromCache('explosion2.png'),
      srcSize: Vector2(192, 192),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.05, to: 7, loop: false);
    position = explosionPosition;
    size = gameRef.size;
    size.multiply(alienShipExplosionSF);
    anchor = Anchor.center;
    removeOnFinish = true;
    FlameAudio.play('explosion2.mp3');
  }
}

class MissileExplosion extends SpriteAnimationComponent with HasGameRef {

  Vector2 explosionPosition;

  MissileExplosion({required this.explosionPosition});

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: Flame.images.fromCache('explosion3.png'),
      srcSize: Vector2(96, 96),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.01, to: 20, loop: false);
    position = explosionPosition;
    size = gameRef.size;
    size.multiply(missileExplosionSF);
    anchor = Anchor.center;
    removeOnFinish = true;
    FlameAudio.play('explosion3.mp3');
  }
}