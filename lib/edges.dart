import 'dart:ui';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/spacestationgame.dart';

class Edges extends BodyComponent {
  final Vector2 gameSize;

  Edges({required this.gameSize});

  @override
  Body createBody() {
    //Allow for gap in rink wall for goal
    final indices = <Vector2>[
      Vector2(0, 0),
      Vector2(0, gameSize.y),
      Vector2(gameSize.x, gameSize.y),
      Vector2(gameSize.x, 0),
      Vector2(0, 0)
    ];

    final shape = ChainShape();
    shape.createChain(indices);
    setColor (const Color(0x00000000));

    final mycontact = EdgesCallback(edges: this);

    final fixtureDef = FixtureDef(
        shape,
        density: 1.0,
        restitution: 0.0,
        friction: 1.0);
    final bodyDef = BodyDef(
        linearVelocity: Vector2.zero(),
        type: BodyType.static,
        userData: mycontact);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class EdgesCallback extends ContactCallbacks {
  final Edges edges;
  late SpaceStationGame parentGame = edges.findParent() as SpaceStationGame;

  EdgesCallback({required this.edges});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
  }

  @override
  void endContact(Object other, Contact contact) {
    super.beginContact(other, contact);
  }
}