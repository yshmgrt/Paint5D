import 'package:flutter/material.dart';
import 'package:paint5d/shapes/shape.dart';

class Image {
  List<Shape> shapes = [];

  void addShape(Shape s) {
    shapes.add(s);
  }

  Shape getLastShape() {
    return shapes[shapes.length - 1];
  }

  void deleteShapesAt(Offset p) {
    shapes = shapes
        .where((element) => !(element.getBoundaries().inflate(10).contains(p) &&
            element.collidesWithCircle(p, 10)))
        .toList();
  }
}
