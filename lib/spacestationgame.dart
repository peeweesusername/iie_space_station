import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/angles.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/edges.dart';
import 'package:iie_space_station/basestation.dart';
import 'package:iie_space_station/directionbutton.dart';
import 'package:iie_space_station/firebutton.dart';
import 'package:iie_space_station/alienspawner.dart';
import 'package:iie_space_station/fireball.dart';

class SpaceStationGame extends Forge2DGame with HasTappables  {
  //Needed to eliminate gravity vector
  SpaceStationGame() : super(gravity: Vector2(0, 0));

  bool gameIsOver = false;
  int score = 0;
  late Body gameBody;
  late Vector2 gameSize;
  late BaseStation theStation;
  late DirectionButtonSprite theDirectionButtonSprite;
  late FireButtonSprite theFireButtonSprite;
  late AlienSpawner seAlienSpawner;
  late AlienSpawner swAlienSpawner;
  late AlienSpawner nwAlienSpawner;
  late AlienSpawner neAlienSpawner;

  //late Function() NewGame;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    gameSize = screenToWorld(camera.viewport.effectiveSize);
    gameBody = world.createBody(BodyDef());
    await FlameAudio.audioCache.load('laser_bolt.mp3');
    await Flame.images.load('base_station.png');
    await Flame.images.load('direction_button.png');
    await Flame.images.load('fire_button.png');
    await Flame.images.load('green_laser_bolt.png');
    await Flame.images.load('red_laser_bolt.png');
    await Flame.images.load('alien_ship.png');
    await Flame.images.load('fireball.gif');

    add(Edges(gameSize: gameSize));

    theStation = BaseStation(
        gameSize: gameSize,
        radius: baseStationSize
    );
    add(theStation);

    theFireButtonSprite = FireButtonSprite(
        gameSize: gameSize,
        radius: fireButtonSize
    );
    add(theFireButtonSprite);

    theDirectionButtonSprite = DirectionButtonSprite(
        gameSize: gameSize,
        radius: directionButtonSize
    );
    add(theDirectionButtonSprite);

    //Create alien spawners
    seAlienSpawner = AlienSpawner(dir: Direction_E.SE);
    swAlienSpawner = AlienSpawner(dir: Direction_E.SW);
    nwAlienSpawner = AlienSpawner(dir: Direction_E.NW);
    neAlienSpawner = AlienSpawner(dir: Direction_E.NE);

    //Add alien spawners
    add(seAlienSpawner);
    add(swAlienSpawner);
    add(nwAlienSpawner);
    add(neAlienSpawner);
  }

  void removeFireBalls() {
    if (children.isNotEmpty) {
      for (var child in children) {
        if (child is FireBall) {
          world.destroyBody(child.body);
          remove(child);
        }
      }
    }
  }

  void gameOver() {
    //TODO: suspend all components, make transparent and overlays.add('GameOverMenu');
    gameIsOver = true;
    removeFireBalls();
    seAlienSpawner.spawnerGameOver();
    swAlienSpawner.spawnerGameOver();
    nwAlienSpawner.spawnerGameOver();
    neAlienSpawner.spawnerGameOver();
    remove(seAlienSpawner);
    remove(swAlienSpawner);
    remove(nwAlienSpawner);
    remove(neAlienSpawner);
    overlays.add('gameOverMenu');
  }

  void restartGame() {
    //TODO: restart the game
    gameIsOver = false;
    score = 0;
    theStation = BaseStation(
        gameSize: gameSize,
        radius: baseStationSize
    );
    add(theStation);

    //Create alien spawners
    seAlienSpawner = AlienSpawner(dir: Direction_E.SE);
    swAlienSpawner = AlienSpawner(dir: Direction_E.SW);
    nwAlienSpawner = AlienSpawner(dir: Direction_E.NW);
    neAlienSpawner = AlienSpawner(dir: Direction_E.NE);

    //Add alien spawners
    add(seAlienSpawner);
    add(swAlienSpawner);
    add(nwAlienSpawner);
    add(neAlienSpawner);
  }
}
