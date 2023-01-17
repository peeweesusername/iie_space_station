import 'dart:async';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iie_space_station/spacestationstatefull.dart';

void main() async {
  //Make sure flame is ready before we launch our game
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  await setupFlame();
  runApp(const SpaceStationApp());
}

class SpaceStationApp extends StatelessWidget {
  const SpaceStationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: SpaceStationGameStatefull(),
    );
  }
}
/// Setup all Flame specific parts
Future setupFlame() async {
  await Flame.device.fullScreen();
  await Flame.device.setOrientation(DeviceOrientation.landscapeLeft);
}