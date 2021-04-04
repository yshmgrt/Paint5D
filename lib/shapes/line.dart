import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paint5d/shapes/shape.dart';
import 'package:paint5d/image.dart' as im;
import 'package:paint5d/action.dart' as act;
import 'package:paint5d/math_utils.dart';

class Line implements Shape {
  List<Offset> points = [];
  double minX = double.infinity;
  double maxX = double.negativeInfinity;
  double minY = double.infinity;
  double maxY = double.negativeInfinity;

  void addPoint(Offset p) {
    points.add(p);
    minX = min(minX, p.dx);
    maxX = max(minX, p.dx);
    minY = min(minY, p.dy);
    maxY = max(maxY, p.dy);
  }

  @override
  void draw(Canvas canvas, Paint paint) {
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool collidesWithCircle(Offset circle, double radius) {
    for (Offset p in points) {
      if (distance(p, circle) <= radius) {
        return true;
      }
    }
    return false;
  }

  @override
  Rect getBoundaries() {
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }
}

class DrawLineAction implements act.Action {
  @override
  final act.ActionData data = act.ActionData("Draw line", Icons.edit);

  @override
  void onPanDown(im.Image image, DragDownDetails details) {
    image.addShape(Line());
  }

  @override
  void onPanEnd(im.Image image, DragEndDetails details) {}

  @override
  void onPanUpdate(im.Image image, DragUpdateDetails details) {
    Shape last = image.getLastShape();
    if (last is Line) {
      last.addPoint(details.localPosition);
    }
  }
}