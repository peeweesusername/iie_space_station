import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:iie_space_station/spacestationgame.dart';
import 'package:iie_space_station/gamemenus.dart';

class SpaceStationGameStatefull extends StatefulWidget {
  const SpaceStationGameStatefull({super.key});
  @override
  State<SpaceStationGameStatefull> createState() => _SpaceStationGameStatefull();
}

class _SpaceStationGameStatefull extends State<SpaceStationGameStatefull> {
  late SpaceStationGame mySpaceStationGame;

  void NewGame() {
    setState(() {
    });
    mySpaceStationGame.restartGame();
  }

  @override
  void initState() {
    super.initState();
    mySpaceStationGame = SpaceStationGame();
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width.toDouble();
    double y = MediaQuery.of(context).size.height.toDouble();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Container(
            constraints: BoxConstraints.expand(width: x, height: y),
            child: GameWidget<SpaceStationGame>(
              game: mySpaceStationGame,
              overlayBuilderMap: const{
                'gameOverMenu': gameOverMenuBuilder
              },
              backgroundBuilder: (context) => Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/StarfieldSimulation.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
