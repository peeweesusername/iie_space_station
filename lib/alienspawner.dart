import 'dart:math';
import 'package:flame/components.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/angles.dart';
import 'package:iie_space_station/alienship.dart';

class AlienSpawner extends Component with HasGameRef {

  Direction_E dir;
  AlienSpawner({required this.dir});

  double spawntimer = 0.0;
  double spawntime = 0.0;
  double fbspeedtimer = 0.0;
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
    spawntimer += dt;
    fbspeedtimer += dt;

    if (spawntimer > spawntime) {
      spawntimer = 0;
      spawntime = (myrnd.nextDouble()*5.0);
      if ((children.isEmpty) && (allowSpawn)) {
        theAlienShip = AlienShip(
            size: galienShipSize,
            gameSize: gameRef.size,
            dir: dir);
        add(theAlienShip);
      }
    }

    if (fbspeedtimer > gfbspeedperiod) {
      fbspeedtimer = 0;
      gfireballspeed += 0.1;
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
      theAlienShip.gameover = true;
    }
  }
}