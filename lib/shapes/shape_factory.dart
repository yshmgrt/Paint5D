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
}
