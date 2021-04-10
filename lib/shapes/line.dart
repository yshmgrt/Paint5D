import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paint5d/math_utils.dart';
import 'package:paint5d/shapes/shape.dart';

class Line extends Shape {
  List<Offset> _points = [];
  double _minX = double.infinity;
  double _maxX = double.negativeInfinity;
  double _minY = double.infinity;
  double _maxY = double.negativeInfinity;

  final Paint paint;
  final double _strokeWidth;

  @override
  Line.create(this.paint, Offset p) : _strokeWidth = paint.strokeWidth {
    addPoint(p);
  }

  void addPoint(Offset p) {
    _points.add(p);
    _minX = min(_minX, p.dx);
    _maxX = max(_minX, p.dx);
    _minY = min(_minY, p.dy);
    _maxY = max(_maxY, p.dy);
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
    return Rect.fromLTRB(_minX, _minY, _maxX, _maxY).inflate(paint.strokeWidth);
  }

  @override
  void update(Offset p) {
    addPoint(p);
  }
}
