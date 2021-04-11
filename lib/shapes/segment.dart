import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paint5d/shapes/shape.dart';
import 'package:paint5d/utils/json_extensions.dart';
import 'package:paint5d/utils/math_utils.dart';

class Segment extends Shape {
  Offset _from;
  Offset _to;
  final Paint paint;

  @override
  Segment.create(this.paint, Offset p) {
    _from = _to = p;
  }

  @override
  void draw(Canvas canvas) {
    canvas.drawLine(_from, _to, paint);
  }

  @override
  bool collidesWithCircle(Offset circle, double radius) =>
      distanceToSegment(circle, Line.fromPoints(_from, _to)) <
      radius + paint.strokeWidth / 2;

  @override
  Rect getBoundaries() {
    return Rect.fromLTRB(min(_from.dx, _to.dx), min(_from.dy, _to.dy),
            max(_from.dx, _to.dx), max(_from.dy, _to.dy))
        .inflate(paint.strokeWidth / 2);
  }

  @override
  void update(Offset p) {
    _to = p;
  }

  @override
  Map<String, dynamic> toJson() => {
        "type": "Segment",
        "paint": paint.toJson(),
        "from": _from.toJson(),
        "to": _to.toJson(),
      };

  Segment.fromJson(Map<String, dynamic> map)
      : paint = JsonablePaint.fromJson(map["paint"]),
        _from = JsonableOffset.fromJson(map["from"]),
        _to = JsonableOffset.fromJson(map["to"]);
}
