import 'package:flame/extensions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/angles.dart';

class AlienShip extends BodyComponent {
  double size;
  Vector2 gameSize;
  Direction_E dir;

  AlienShip({
    required this.size,
    required this.gameSize,
    required this.dir});

  late SpriteComponent alienShipSprite;
  bool destroy = false;

  @override
  Body createBody() {
    double angle = computeAlienShipAngle(dir, gameSize);
    Vector2 alienShipPosition = computeAlienShipPosition(size, dir, gameSize);

    /*
    //Add Sprite with image of alien ship
    Image alienShipImage = Flame.images.fromCache('alien_ship.png');
    alienShipSprite = SpriteComponent.fromImage(
        alienShipImage,
        anchor: Anchor.center,
        size: Vector2(l, w)
    );
    add(alienShipSprite);
    */

    final shape = CircleShape();
    shape.radius = size;
    setColor (const Color(0xFFFF4100));

    final mycontact = AlienShipCallback(alienShip: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(
        position: alienShipPosition,
        linearVelocity: Vector2.zero(),
        angle: angle,
        angularVelocity: 0,
        type: BodyType.static,
        bullet: true,
        fixedRotation: true,
        userData: mycontact
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (destroy) {
      destroy = false;
      world.destroyBody(body);
      removeFromParent();
      //TODO: explosion here
    }
    else {
      //TODO: ship fires here
    }
  }

  Vector2 computeAlienShipPosition(double size, Direction_E dir, Vector2 gameSize) {
    double xpos = 0.0;
    double ypos = 0.0;

    switch (dir) {
      case Direction_E.SE: {
        //Ship is in the NW corner
        xpos = size; //left
        ypos = size; //top
      }
      break;
      case Direction_E.SW: {
        //Ship is in the NE corner
        xpos = gameSize.x - size; //right
        ypos = size; //top
      }
      break;
      case Direction_E.NW: {
        //Ship is in the SE corner
        xpos = gameSize.x - size; //right
        ypos = gameSize.y - size; //bottom
      }
      break;
      case Direction_E.NE: {
        //Ship is in the SW corner
        xpos = size; //left
        ypos = gameSize.y - size; //bottom
      }
      break;
    }
    return Vector2(xpos,ypos);
  }
}

class AlienShipCallback extends ContactCallbacks {
  final AlienShip alienShip;

  AlienShipCallback({required this.alienShip});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
    //AlienShips will always be blowed up upon contact
    if (other is !AlienShipCallback) {
      alienShip.destroy = true;
    }
  }
}

