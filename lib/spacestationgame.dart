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

class SpaceStationGame extends Forge2DGame with HasTappables  {
  //Needed to eliminate gravity vector
  SpaceStationGame() : super(gravity: Vector2(0, 0));

  late Body gameBody;
  late Vector2 gameSize;
  late BaseStation theStation;
  late DirectionButtonSprite theDirectionButtonSprite;
  late FireButtonSprite theFireButtonSprite;

  late Function() NewGame;

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
    //Unable to load asset: assets/images/fireball.gif
    //await Flame.images.load('fireball.gif');

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

    add(AlienSpawner(dir: Direction_E.SE));
    add(AlienSpawner(dir: Direction_E.SW));
    add(AlienSpawner(dir: Direction_E.NW));
    add(AlienSpawner(dir: Direction_E.NE));
  }

  void gameOver() {
    //TODO: suspend all components, make transparent and overlays.add('GameOverMenu');
  }
  void restartGame() {
    //TODO: restart the game
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    if (!info.handled) {
    }
  }
}
