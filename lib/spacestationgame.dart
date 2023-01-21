import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/basestation.dart';
import 'package:iie_space_station/directionbutton.dart';
import 'package:iie_space_station/firebutton.dart';

class SpaceStationGame extends Forge2DGame with HasTappables  {
  //Needed to eliminate gravity vector
  SpaceStationGame() : super(gravity: Vector2(0, 0));

  late Body gameBody;
  late Vector2 gameSize;
  late BaseStation theStation;
  late DirectionButton theDirectionButton;
  late FireButton theFireButton;

  late Function() NewGame;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    camera.zoom = camera.zoom * myZoomFactor;
    gameSize = screenToWorld(camera.viewport.effectiveSize);
    gameBody = world.createBody(BodyDef());
    //await FlameAudio.audioCache.load('charge.mp3');
    //await FlameAudio.audioCache.load('score_air_horn.mp3');
    await Flame.images.load('base_station.png');
    await Flame.images.load('direction_button.png');
    await Flame.images.load('fire_button.png');

    theStation = BaseStation(
        gameSize: gameSize,
        radius: baseStationSize
    );
    add(theStation);

    theDirectionButton = DirectionButton(
        gameSize: gameSize,
        radius: directionButtonSize
    );
    add(theDirectionButton);

    theFireButton = FireButton(
        gameSize: gameSize,
        radius: fireButtonSize
    );
    add(theFireButton);

    //overlays.add('FaceoffMenu');
  }

  void restartGame() {
    //overlays.add('FaceoffMenu');
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    if (!info.handled) {
      print('game handles tapdown');
    }
  }
}
