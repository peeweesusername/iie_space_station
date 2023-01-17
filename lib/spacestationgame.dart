import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
//import 'package:iie_space_station/globals.dart';
//import 'package:iie_space_station/component1.dart';
//import 'package:iie_space_station/component2.dart';


class SpaceStationGame extends Forge2DGame with HasDraggables, TapDetector {
  //Needed to eliminate gravity vector
  SpaceStationGame() : super(gravity: Vector2(0, 0));

  late Body gameBody;
  late Vector2 gameSize;

  late Function() NewGame;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //camera.zoom = camera.zoom * myZoomFactor;
    camera.zoom = camera.zoom;
    gameSize = screenToWorld(camera.viewport.effectiveSize);
    gameBody = world.createBody(BodyDef());
    //await FlameAudio.audioCache.load('charge.mp3');
    //await FlameAudio.audioCache.load('score_air_horn.mp3');
    //add(component1);
    //add(component2);
    //overlays.add('FaceoffMenu');
  }

  void restartGame() {
    //overlays.add('FaceoffMenu');
  }

  @override
  void onTap() {
    if (paused) {
      resumeEngine();
    } else {
      pauseEngine();
    }
  }
}
