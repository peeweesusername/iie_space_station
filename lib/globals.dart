library iie_space_station.globals;

import 'package:flame/components.dart';

const double baseStationSize = 6.0;
const double baseStationScale = 2.0;

const double directionButtonSize = 12.0;
const double fireButtonSize = 12.0;

const double laserBoltL = 2.0;
const double laserBoltW = 0.4;
const double lbSpeed  = 40.0;

const double alienShipSize = 5.0;
const double alienShipScale = 2.0;

const double fireBallL = 2.0;
const double fireBallW = 2.0;
const double fireBallR = 2.0;
const double fbInitSpeed  = 2.0;

const double baseStationExplostionSFX = 0.4375;
const double baseStationExplostionSFY = 0.7778;
Vector2 baseStationExplostionSF = Vector2(
    baseStationExplostionSFX,
    baseStationExplostionSFY
);

const double alienShipExplostionSFX = baseStationExplostionSFX/2;
const double alienShipExplostionSFY = baseStationExplostionSFY/2;
Vector2 alienShipExplostionSF = Vector2(
    alienShipExplostionSFX,
    alienShipExplostionSFY
);



