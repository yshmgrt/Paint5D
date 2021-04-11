import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paint5d/shapes/shape.dart';
import 'package:paint5d/utils/json_extensions.dart';
import 'package:paint5d/utils/math_utils.dart';

class Line extends Shape {
  List<Offset> _points = [];
  Rect _bound;

  final Paint paint;
  final double _strokeWidth;

  @override
  Line.create(this.paint, Offset p) : _strokeWidth = paint.strokeWidth {
    addPoint(p);
    _bound = Rect.fromCenter(center: p, width: 0, height: 0);
  }

  void addPoint(Offset p) {
    _points.add(p);
    Rect pointRect = Rect.fromCenter(center: p, width: 0, height: 0);
    if (_bound == null) {
      _bound = pointRect;
    } else {
      _bound = _bound.expandToInclude(pointRect);
    }
  }

  @override
  void draw(Canvas canvas) {
    canvas.drawPoints(
        PointMode.polygon, _points, paint..strokeWidth = _strokeWidth + 2);
    for (int i = 0; i < _points.length; i++) {
      canvas.drawCircle(
          _points[i],
          1,
          paint
            ..style = PaintingStyle.stroke
            ..isAntiAlias = true
            ..strokeWidth = _strokeWidth);
    }
  }

  @override
  bool collidesWithCircle(Offset circle, double radius) {
    for (Offset p in _points) {
      if (distance(p, circle) <= radius + paint.strokeWidth / 2) {
        return true;
      }
    }
    return false;
  }

  @override
  Rect getBoundaries() {
    return _bound.inflate(paint.strokeWidth);
  }

  @override
  void update(Offset p) {
    addPoint(p);
  }

  @override
  Map<String, dynamic> toJson() => {
        "type": "Line",
        "paint": paint.toJson(),
        "data": _points.map((e) => e.toJson()).toList(),
        "tl": _bound.topLeft.toJson(),
        "br": _bound.bottomRight.toJson(),
      };

  Line.fromJson(Map<String, dynamic> map)
      : paint = JsonablePaint.fromJson(map["paint"])
          ..style = PaintingStyle.stroke,
        _strokeWidth = JsonablePaint.fromJson(map["paint"]).strokeWidth,
        _points = (map["data"] as List<dynamic>)
            .map((e) => JsonableOffset.fromJson(e))
            .toList(),
        _bound = Rect.fromPoints(JsonableOffset.fromJson(map["tl"]),
            JsonableOffset.fromJson(map["br"]));
}
