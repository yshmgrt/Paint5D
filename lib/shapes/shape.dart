import 'package:flutter/material.dart';

abstract class Shape {
  void draw(Canvas canvas, Paint paint);
  bool collidesWithCircle(Offset circle, double radius);
  Rect getBoundaries();
}
