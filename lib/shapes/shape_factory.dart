import 'package:flutter/material.dart';
import 'package:paint5d/shapes/line.dart';
import 'package:paint5d/shapes/rectangle.dart';
import 'package:paint5d/shapes/segment.dart';
import 'package:paint5d/shapes/shape.dart';

enum ShapeType {
  LINE,
  RECTANGLE,
  SEGMENT,
}

class ShapeFactory {
  Paint _currentPaint;

  set paint(Paint paint) => _currentPaint = paint;

  Shape createShape(ShapeType type, Offset startPoint) {
    _currentPaint = Paint()
      ..strokeWidth = _currentPaint.strokeWidth
      ..color = _currentPaint.color;
    switch (type) {
      case ShapeType.LINE:
        return Line.create(_currentPaint, startPoint);
      case ShapeType.RECTANGLE:
        return Rectangle.create(_currentPaint, startPoint);
      case ShapeType.SEGMENT:
        return Segment.create(_currentPaint, startPoint);
    }
    throw new UnsupportedError("Unsupported shape");
  }

  static Shape fromJson(Map<String, dynamic> map) {
    switch (map["type"]) {
      case "Line":
        return Line.fromJson(map);
      case "Segment":
        return Segment.fromJson(map);
      case "Rectangle":
        return Rectangle.fromJson(map);
    }
    throw new UnsupportedError("Unsupported shape");
  }
}
