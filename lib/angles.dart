import 'dart:math' as math;
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:iie_space_station/globals.dart';

enum Direction_E {
  NE,
  SE,
  SW,
  NW
}

Direction_E determineQuadrant (double x, double y) {
  if (x > 0) {
    if (y > 0) {
      return Direction_E.NE;
    }
    else {
      return Direction_E.SE;
    }
  }
  else {
    if (y > 0) {
      return Direction_E.NW;
    }
    else {
      return Direction_E.SW;
    }
  }
}

//Returns value in radians
double computeStationAngle (Direction_E direction, Vector2 boxSize) {
  double a = 0.0;
  double x = boxSize.x;
  double y = boxSize.y;
  switch(direction) {
    case Direction_E.NE:
      {
        a = math.atan( ((x-galienShipSize)-(x/2)) / ((y-galienShipSize)-(y/2)) );
        return a;
      }
    case Direction_E.SE:
      {
        a = math.atan( ((y-galienShipSize)-(y/2)) / ((x-galienShipSize)-(x/2)) );
        return a + (math.pi/2.0);
      }
    case Direction_E.SW:
      {
        a = math.atan( ((x-galienShipSize)-(x/2)) / ((y-galienShipSize)-(y/2)) );
        return a + math.pi;
      }
    case Direction_E.NW:
      {
        a = math.atan( ((y-galienShipSize)-(y/2)) / ((x-galienShipSize)-(x/2)) );
        return a + (3.0*math.pi/2.0);
      }
  }
}

//Returns value in radians
double computeAlienShipAngle (Direction_E direction, Vector2 boxSize) {
  double a = 0.0;
  double x = boxSize.x;
  double y = boxSize.y;
  switch(direction) {
    case Direction_E.NE:
      {
        a = math.atan( ((x-galienShipSize)-(x/2)) / ((y-galienShipSize)-(y/2)) );
        return a + math.pi;
      }
    case Direction_E.SE:
      {
        a = math.atan( ((y-galienShipSize)-(y/2)) / ((x-galienShipSize)-(x/2)) );
        return a + (3.0*math.pi/2.0);
      }
    case Direction_E.SW:
      {
        a = math.atan( ((x-galienShipSize)-(x/2)) / ((y-galienShipSize)-(y/2)) );
        return a;
      }
    case Direction_E.NW:
      {
        a = math.atan( ((y-galienShipSize)-(y/2)) / ((x-galienShipSize)-(x/2)) );
        return a + (math.pi/2.0);
      }
  }
}