import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class FireButton extends BodyComponent with Tappable {
  double radius;
  Vector2 gameSize;

  FireButton({required this.gameSize, required this.radius});

  late SpriteComponent fireButtonSprite;
  late Vector2 fireButtonPosition;

  @override
  Body createBody() {
    //Add Sprite with image of space direction button
    Image fireStationImage = Flame.images.fromCache('fire_button.png');
    fireButtonSprite = SpriteComponent.fromImage(
      fireStationImage,
      anchor: Anchor.center,
      size: Vector2(radius, radius),
    );

    double xpos = ((fireButtonSprite.size.x) / 2);
    fireButtonPosition = Vector2(xpos, gameSize.y / 2);
    add(fireButtonSprite);

    final shape = CircleShape();
    shape.radius = radius/2;
    setColor (const Color(0x00000000));

    final bodyDef = BodyDef(position: fireButtonPosition, linearVelocity: Vector2.zero(), type: BodyType.static);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    print('firebutton handles tapdown');
    info.handled = true;
    return true;
  }
}
