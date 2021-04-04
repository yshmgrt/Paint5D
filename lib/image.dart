import 'package:paint5d/shapes/shape.dart';

class Image {
  List<Shape> shapes = [];
  void addShape(Shape s) {
    shapes.add(s);
  }

  Shape getLastShape() {
    return shapes[shapes.length - 1];
  }
}