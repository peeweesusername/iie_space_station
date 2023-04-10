import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iie_space_station/spacestationgame.dart';

String initials = '';

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

Widget enterInitialsMenuBuilder(BuildContext buildContext, SpaceStationGame game) {

  return Center(
    child: Container(
      color: Colors.transparent,
      child:  Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SizedBox (
                width: 400,
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLength: 3,
                  style: const TextStyle(fontSize: 24, color: Color(0xFF41FF00)),
                  textCapitalization: TextCapitalization.characters,
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color:Color(0xFF41FF00))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xFF41FF00))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xFF41FF00))),
                    labelText: 'Enter your initials',
                    labelStyle: TextStyle(fontSize: 24, color: Color(0xFF41FF00)),
                  ),
                onSubmitted: (text) {
                  initials = text;
                  },
                ),
              ),
            ),
            GestureDetector(
                onTap: () async {
                  await game.theTopScores.addNewScore(game.theScore.score, initials);
                  await game.theTopScores.saveScores();
                  game.overlays.add('topScores');
                  game.overlays.remove('enterInitials');
                },
                child: const Text('Done', style: TextStyle(fontSize: 24, color: Color(0xFF41FF00)))
            ),
            const Text('', style: TextStyle(fontSize: 24)),
            const Text('', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    ),
  );
}
