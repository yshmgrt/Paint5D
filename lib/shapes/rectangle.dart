import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paint5d/math_utils.dart';
import 'package:paint5d/shapes/shape.dart';

class Rectangle extends Shape {
  Offset _topLeft;
  Offset _bottomRight;
  final Paint paint;

  @override
  Rectangle.create(this.paint, Offset p) {
    _topLeft = _bottomRight = p;
    paint.style = PaintingStyle.stroke;
  }

  @override
  void draw(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTRB(
            _topLeft.dx, _topLeft.dy, _bottomRight.dx, _bottomRight.dy),
        paint);
  }

  @override
  bool collidesWithCircle(Offset circle, double radius) {
    var a = _topLeft;
    var b = Offset(_topLeft.dx, _bottomRight.dy);
    var c = _bottomRight;
    var d = Offset(_bottomRight.dx, _topLeft.dy);
    var ab = Line.fromPoints(a, b);
    var bc = Line.fromPoints(b, c);
    var cd = Line.fromPoints(c, d);
    var da = Line.fromPoints(d, a);
    return distanceToSegment(circle, ab) < radius + paint.strokeWidth / 2 ||
        distanceToSegment(circle, bc) < radius + paint.strokeWidth / 2 ||
        distanceToSegment(circle, cd) < radius + paint.strokeWidth / 2 ||
        distanceToSegment(circle, da) < radius + paint.strokeWidth / 2;
  }

  @override
  Rect getBoundaries() {
    return Rect.fromLTRB(
            min(_topLeft.dx, _bottomRight.dx),
            min(_topLeft.dy, _bottomRight.dy),
            max(_topLeft.dx, _bottomRight.dx),
            max(_topLeft.dy, _bottomRight.dy))
        .inflate(paint.strokeWidth / 2);
  }

  @override
  void update(Offset p) {
    _bottomRight = p;
  }
}
