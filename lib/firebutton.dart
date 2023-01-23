import 'package:flame/events.dart';
import 'package:flame/components.dart';

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
    print('firebutton handles tapdown');
    info.handled = true;
    return true;
  }
}
