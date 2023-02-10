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
            Text('Your score: ${game.score}', style: const TextStyle(fontSize: 24, color: Color(0xFF41FF00))),
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
                child: const Text('Exit Game', style: TextStyle(fontSize: 24, color: Color(0xFF41FF00)))),
          ],
        ),
      ),
    ),
  );
}
