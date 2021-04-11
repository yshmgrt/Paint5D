import 'package:flutter/material.dart';

abstract class Shape {
  Shape();

  void draw(Canvas canvas);

  bool collidesWithCircle(Offset circle, double radius);

  Rect getBoundaries();

  void update(Offset p);

  Paint get paint;

  Map<String, dynamic> toJson();

  Shape.fromJson(Map<String, dynamic> map);
}
