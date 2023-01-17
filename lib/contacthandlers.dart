import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/spacestationgame.dart';
import 'package:iie_space_station/basestation.dart';

class baseStationCallback extends ContactCallbacks {
  final BaseStation baseStation;
  late SpaceStationGame parentGame = baseStation.findParent() as SpaceStationGame;

  baseStationCallback({required this.baseStation});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
  }

  @override
  void endContact(Object other, Contact contact) {
    super.beginContact(other, contact);
  }
}

