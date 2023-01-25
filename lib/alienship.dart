import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/angles.dart';
import 'package:iie_space_station/spacestationgame.dart';

class AlienShip extends BodyComponent {
  double l;
  double w;
  Vector2 gameSize;
  Direction_E dir;

  AlienShip({
    required this.l,
    required this.w,
    required this.gameSize,
    required this.dir});

  static double then = 0;
  static double count = 0;

  late SpriteComponent alienShipSprite;

  @override
  Body createBody() {
    double angle = computeAlienShipAngle(dir, gameSize);
    Vector2 alienShipPosition = Vector2.zero();

    /*
    //Add Sprite with image of laser bolt
    Image alienShipImage = Flame.images.fromCache('alien_ship.png');
    alienShipSprite = SpriteComponent.fromImage(
        alienShipImage,
        anchor: Anchor.center,
        size: Vector2(l, w)
    );
    add(alienShipSprite);
    */

    final shape = PolygonShape();
    shape.setAsBoxXY(l, w);
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
    then += dt;
    // TODO: implement update
    super.update(dt);
    if (then > 1.0) {
      count++;
      print(count.toString());
      then = 0;
    }
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
      alienShip.removeFromParent();
      //Do explosion and sound
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    super.beginContact(other, contact);
  }
}

class AlienSpawner extends Component with HasGameRef {

  //This will be added to the parent game
  //Creates all four alien objects
  //Then adds/removes to the parent game
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}
