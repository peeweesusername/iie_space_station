import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/angles.dart';
import 'package:iie_space_station/spacestationgame.dart';
import 'package:iie_space_station/alienship.dart';

class AlienSpawner extends Component with HasGameRef {

  //This will be added to the parent game
  //Creates all four alien objects
  //Then adds/removes to the parent game

  late AlienShip neAlienShip;
  static double then = 0;
  static double count = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    neAlienShip = AlienShip(
        l: alienShipL,
        w: alienShipL,
        gameSize: (gameRef as SpaceStationGame).gameSize,
        dir: Direction_E.NE);
  }

  @override
  void update(double dt) {
    then += dt;
    // TODO: implement update
    super.update(dt);
    //print("update "+then.round().toString());
    if (then.round() % 5 == 0) {
      if (!neAlienShip.isMounted){
        print("adding alien ship");
        (gameRef as SpaceStationGame).add(neAlienShip);
      }
    }
  }
}