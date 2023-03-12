library iie_space_station.globals;

import 'package:flame/components.dart';

const double baseStationSize = 6.0;
const double baseStationScale = 2.0;

const double directionButtonSize = 12.0;
const double fireButtonSize = 12.0;

const double laserBoltL = 2.0;
const double laserBoltW = 1.0;
const double lbSpeed  = 40.0;

const double alienShipSize = 5.0;
const double alienShipScale = 2.0;

const double fireBallL = 2.0;
const double fireBallW = 2.0;
const double fireBallR = 2.0;
const double fbInitSpeed  = 2.0;

const double baseStationExplosionSFX = 0.4375;
const double baseStationExplosionSFY = 0.7778;
Vector2 baseStationExplosionSF = Vector2(
    baseStationExplosionSFX,
    baseStationExplosionSFY
);

const double alienShipExplosionSFX = baseStationExplosionSFX/2;
const double alienShipExplosionSFY = baseStationExplosionSFY/2;
Vector2 alienShipExplosionSF = Vector2(
    alienShipExplosionSFX,
    alienShipExplosionSFY
);

const double missileExplosionSFX = baseStationExplosionSFX/10;
const double missileExplosionSFY = baseStationExplosionSFY/10;
Vector2 missileExplosionSF = Vector2(
    missileExplosionSFX,
    missileExplosionSFY
);



