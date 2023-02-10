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
  double fireballspeed = fbInitSpeed;
  Random myrnd = Random();
  bool allowSpawn = true;
  late AlienShip theAlienShip;

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
      if ((children.isEmpty) && (allowSpawn)) {
        theAlienShip = AlienShip(
            size: alienShipSize,
            fbSpeed: fireballspeed,
            gameSize: (gameRef as SpaceStationGame).gameSize,
            dir: dir);
        add(theAlienShip);
        fireballspeed++;
      }
    }
  }

  void stopSpawning() {
    allowSpawn = false;
  }

  void startSpawning() {
    allowSpawn = true;
  }

  void destroyAlienShip() {
    if (children.isNotEmpty) {
      theAlienShip.destroy = true;
    }
  }

  void spawnerGameOver() {
    stopSpawning();
    if (children.isNotEmpty) {
      theAlienShip.destroy = true;
    }
  }
}