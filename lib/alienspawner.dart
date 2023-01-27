import 'dart:math';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/angles.dart';
import 'package:iie_space_station/spacestationgame.dart';
import 'package:iie_space_station/alienship.dart';

class AlienSpawner extends Component with HasGameRef {

  double time = 0;
  double spawntime = 0.0;
  Random myrnd = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    spawntime = (myrnd.nextDouble()*5.0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;

    /*
    var myiterator = children.iterator;
    while (myiterator.moveNext()) {
      if (myiterator.current is AlienShip) {
        AlienShip myAlienShip = myiterator.current as AlienShip;
      }
    }
    */

    if (time > spawntime) {
      time = 0;
      spawntime = (myrnd.nextDouble()*5.0);
      if (children.isEmpty) {
        add(AlienShip(
            l: alienShipL,
            w: alienShipL,
            gameSize: (gameRef as SpaceStationGame).gameSize,
            dir: Direction_E.NE)
        );
      }
    }
  }
}