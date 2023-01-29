import 'dart:math';
import 'package:flame/components.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/angles.dart';
import 'package:iie_space_station/spacestationgame.dart';
import 'package:iie_space_station/alienship.dart';

class AlienSpawner extends Component with HasGameRef {

  Direction_E dir;
  AlienSpawner({required this.dir});

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

    if (time > spawntime) {
      time = 0;
      spawntime = (myrnd.nextDouble()*5.0);
      if (children.isEmpty) {
        add(AlienShip(
            size: alienShipSize,
            gameSize: (gameRef as SpaceStationGame).gameSize,
            dir: dir)
        );
      }
    }
  }
}