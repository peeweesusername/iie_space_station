import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';
import 'package:iie_space_station/basestation.dart';

class SpaceStationGame extends Forge2DGame with HasDraggables, TapDetector {
  //Needed to eliminate gravity vector
  SpaceStationGame() : super(gravity: Vector2(0, 0));

  late Body gameBody;
  late Vector2 gameSize;
  Vector2 baseStationPosition = Vector2.zero();
  late BaseStation theStation;

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
    baseStationPosition = Vector2(gameSize.x / 2, gameSize.y / 2);
    theStation = BaseStation(
        position: baseStationPosition,
        radius: baseStationSize,
        linearVelocity: Vector2.zero()
    );
    add(theStation);
    //add(component1);
    //add(component2);
    //overlays.add('FaceoffMenu');
  }

  void restartGame() {
    //overlays.add('FaceoffMenu');
  }

  @override
  void onTap() {
    print("tapped");
    theStation.rotate(45);
    /*
    if (paused) {
      resumeEngine();
    } else {
      pauseEngine();
    }
     */
  }
}
