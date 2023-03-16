import 'dart:math';
import 'package:flame/extensions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/alienspawner.dart';
import 'package:iie_space_station/angles.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/fireball.dart';
import 'package:iie_space_station/spacestationgame.dart';
import 'package:iie_space_station/explosions.dart';

class AlienShip extends BodyComponent {
  double size;
  double fbSpeed;
  Vector2 gameSize;
  Direction_E dir;

  AlienShip({
    required this.size,
    required this.fbSpeed,
    required this.gameSize,
    required this.dir});

  late SpriteComponent alienShipSprite;
  bool destroy = false;
  bool gameover = false;
  bool clearToFire = true;
  double time = 0;
  double fireTime = 0.0;
  double alienShipAngle = 0.0;
  Vector2 alienShipPosition = Vector2.zero();
  Random myRND = Random();

  @override
  Body createBody() {
    size = 5;
    alienShipAngle = computeAlienShipAngle(dir, gameSize);
    alienShipPosition = computeAlienShipPosition(size, dir, gameSize);

    //Add Sprite with image of alien ship
    Image alienShipImage = Flame.images.fromCache('alien_ship.png');
    alienShipSprite = SpriteComponent.fromImage(
        alienShipImage,
        anchor: Anchor.center,
        size: Vector2(size*alienShipScale, size*alienShipScale)
    );
    add(alienShipSprite);

    final shape = CircleShape();
    shape.radius = size;
    setColor (const Color(0x00FF4100));

    final mycontact = AlienShipCallback(alienShip: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(
        position: alienShipPosition,
        linearVelocity: Vector2.zero(),
        angle: alienShipAngle,
        angularVelocity: 0,
        type: BodyType.static,
        fixedRotation: true,
        userData: mycontact
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;

    if (destroy) {
      destroy = false;
      world.destroyBody(body);
      removeFromParent();
      gameRef.add(AlienShipExplosion(explosionPosition: alienShipPosition));
    }
    else if (gameover) {
      gameover = false;
      world.destroyBody(body);
      removeFromParent();
    }
    else {
      if((time > fireTime) && (clearToFire)){
        time = 0;
        fireTime = (myRND.nextDouble()*3.0) + 2.0;
        print (fireTime);
        gameRef.add(FireBall(
            l: fireBallL,
            w: fireBallW,
            a: alienShipAngle,
            gl: size,
            speed: fbSpeed,
            originCenter: alienShipPosition)
        );
      }
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

  void CeaseFire(){
    clearToFire = false;
  }

  void OpenFire(){
    clearToFire = true;
  }
}

class AlienShipCallback extends ContactCallbacks {
  final AlienShip alienShip;

  AlienShipCallback({required this.alienShip});

  late AlienSpawner parent = alienShip.findParent() as AlienSpawner;

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
    //AlienShips will always be blowed up upon contact
    if (other is !FireBallCallback) {
      alienShip.destroy = true;
      (parent.gameRef as SpaceStationGame).theScore.score += 5;
    }
  }
}

