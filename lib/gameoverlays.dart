import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iie_space_station/spacestationgame.dart';

Widget gameOverMenuBuilder(BuildContext buildContext, SpaceStationGame game) {
  return Center(
    child: Container(
      color: Colors.transparent,
      child:  Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: (){
                  game.overlays.add('topScores');
                  game.overlays.remove('gameOverMenu');
                },
                child: const Text('High Scores', style: TextStyle(fontSize: 24, color: Color(0xFF41FF00)))),
            const Text('', style: TextStyle(fontSize: 24)),
            GestureDetector(
                onTap: (){
                  game.overlays.remove('gameOverMenu');
                  game.restartGame();
                },
                child: const Text('Try again', style: TextStyle(fontSize: 24, color: Color(0xFF41FF00)))),
            const Text('', style: TextStyle(fontSize: 24)),
            GestureDetector(
                onTap: (){
                  SystemNavigator.pop();
                },
                child: const Text('Exit Game', style: TextStyle(fontSize: 24, color: Color(0xFF41FF00)))
            ),
            //TODO - Add a GestureDetector with onTap to load top scores overlay
          ],
        ),
      ),
    ),
  );
}

Widget topScoresMenuBuilder(BuildContext buildContext, SpaceStationGame game) {
  return Center(
    child: Container(
      color: Colors.transparent,
      child:  Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Top Five', style: TextStyle(
              fontSize: 24,
              color: Color(0xFF41FF00),
              decoration: TextDecoration. underline,)
            ),
            ...game.theTopScores.highScoresList(),
            const Text('', style: TextStyle(fontSize: 24)),
            GestureDetector(
                onTap: (){
                  game.overlays.add('gameOverMenu');
                  game.overlays.remove('topScores');
                },
                child: const Text('Dismiss', style: TextStyle(fontSize: 24, color: Color(0xFF41FF00)))
            ),
          ],
        ),
      ),
    ),
  );
}
