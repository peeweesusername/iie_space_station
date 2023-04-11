library iie_space_station.globals;

import 'package:flame/components.dart';

const double gbaseStationSize = 6.0;
const double gbaseStationScale = 2.0;

const double gdirectionButtonSize = 12.0;
const double gfireButtonSize = 12.0;

const double glaserBoltL = 2.0;
const double glaserBoltW = 1.0;
const double glbSpeed  = 40.0;

const double galienShipSize = 5.0;
const double galienShipScale = 2.0;

const double gfireBallL = 2.0;
const double gfireBallW = 2.0;
const double gfireBallR = 2.0;
const double gfbInitSpeed  = 2.0;
double gfireballspeed = gfbInitSpeed;
const double gfbspeedperiod = 5;

const double gbaseStationExplosionSFX = 0.4375;
const double gbaseStationExplosionSFY = 0.7778;
Vector2 gbaseStationExplosionSF = Vector2(
    gbaseStationExplosionSFX,
    gbaseStationExplosionSFY
);

const double galienShipExplosionSFX = gbaseStationExplosionSFX/2;
const double galienShipExplosionSFY = gbaseStationExplosionSFY/2;
Vector2 galienShipExplosionSF = Vector2(
    galienShipExplosionSFX,
    galienShipExplosionSFY
);

const double gmissileExplosionSFX = gbaseStationExplosionSFX/10;
const double gmissileExplosionSFY = gbaseStationExplosionSFY/10;
Vector2 gmissileExplosionSF = Vector2(
    gmissileExplosionSFX,
    gmissileExplosionSFY
);

const int gmaxNumberScores = 5;



