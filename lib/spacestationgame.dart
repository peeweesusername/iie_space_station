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
import 'package:iie_space_station/scorecomponent.dart';
import 'package:iie_space_station/topscores.dart';

class SpaceStationGame extends Forge2DGame with HasTappables  {
  //Needed to eliminate gravity vector
  SpaceStationGame() : super(gravity: Vector2(0, 0));

  bool gameIsOver = false;
  late BaseStation theStation;
  late DirectionButtonSprite theDirectionButtonSprite;
  late FireButtonSprite theFireButtonSprite;
  late AlienSpawner seAlienSpawner;
  late AlienSpawner swAlienSpawner;
  late AlienSpawner nwAlienSpawner;
  late AlienSpawner neAlienSpawner;
  late ScoreComponent theScore;
  late TopScores theTopScores;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await Flame.images.load('base_station.png');
    await Flame.images.load('direction_button.png');
    await Flame.images.load('fire_button.png');
    await Flame.images.load('green_laser_bolt.png');
    await Flame.images.load('red_laser_bolt.png');
    await Flame.images.load('alien_ship.png');
    await Flame.images.load('fireball.png');
    await Flame.images.load('explosion1.png');
    await Flame.images.load('explosion2.png');
    await Flame.images.load('explosion3.png');
    await FlameAudio.audioCache.load('laser_bolt.mp3');
    await FlameAudio.audioCache.load('explosion1.mp3');
    await FlameAudio.audioCache.load('explosion2.mp3');
    await FlameAudio.audioCache.load('explosion3.mp3');
    await FlameAudio.audioCache.load('blaster.mp3');

    add(Edges(gameSize: size));

    theStation = BaseStation(
        gameSize: size,
        radius: gbaseStationSize
    );
    add(theStation);

    theFireButtonSprite = FireButtonSprite(
        gameSize: size,
        radius: gfireButtonSize
    );
    add(theFireButtonSprite);

    theDirectionButtonSprite = DirectionButtonSprite(
        gameSize: size,
        radius: gdirectionButtonSize
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


    //Top scores
    theTopScores = TopScores();
    theTopScores.loadScores();

    //Add score
    theScore = ScoreComponent();
    add(theScore);
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

  Future<void> gameOver() async {
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
    if(theTopScores.ifInTopScores(theScore.score)) {
      overlays.add('enterInitials');
    }
    else {
      overlays.add('gameOverMenu');
    }
  }

  void restartGame() {
    gameIsOver = false;
    theScore.score = 0;
    gfireballspeed = gfbInitSpeed;
    theStation = BaseStation(
        gameSize: size,
        radius: gbaseStationSize
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
