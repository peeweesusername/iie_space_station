import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:iie_space_station/spacestationgame.dart';

class ScoreComponent extends TextComponent with HasGameRef {

  int _score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    const greenTextStyle = TextStyle(fontSize: 3, color: Color(0xFF41FF00));
    final greenRenderer = TextPaint(style: greenTextStyle);
    text = 'Your score: $_score';
    position = Vector2(gameRef.size.x/2, 1.5);
    anchor = Anchor.center;
    textRenderer = greenRenderer;
  }

  int get score {
    return _score;
  }

  set score(int i) {
    _score = i;
    if ((game as SpaceStationGame).theTopScores.ifInTopScores(_score)) {
      text = 'Your score $_score is in the top five!';
    }
    else {
      text = 'Your score: $_score';
    }
  }
}
