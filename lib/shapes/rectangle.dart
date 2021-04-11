import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paint5d/shapes/shape.dart';
import 'package:paint5d/utils/json_extensions.dart';

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
    return getBoundaries().contains(circle) &&
        !getBoundaries().deflate(paint.strokeWidth).contains(circle);
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

  @override
  Map<String, dynamic> toJson() => {
        "type": "Rectangle",
        "paint": paint.toJson(),
        "tl": _topLeft.toJson(),
        "br": _bottomRight.toJson(),
      };

  Rectangle.fromJson(Map<String, dynamic> map)
      : paint = JsonablePaint.fromJson(map["paint"])
          ..style = PaintingStyle.stroke,
        _topLeft = JsonableOffset.fromJson(map["tl"]),
        _bottomRight = JsonableOffset.fromJson(map["br"]);
}
