import 'package:flutter/material.dart';
import 'package:paint5d/shapes/shape.dart';
import 'package:paint5d/image.dart' as im;
import 'package:paint5d/action.dart' as act;

class Line implements Shape {
  List<Offset> points = [];

  void addPoint(Offset p) {
    points.add(p);
  }

  @override
  void draw(Canvas canvas, Paint paint) {
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
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