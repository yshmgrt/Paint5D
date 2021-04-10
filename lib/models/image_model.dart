import 'package:flutter/material.dart';
import 'package:paint5d/shapes/shape.dart';

class ImageModel with ChangeNotifier {
  List<Shape> _shapes = [];

  void addShape(Shape s) {
    _shapes.add(s);
    notifyListeners();
  }

  Shape get currentShape => _shapes[_shapes.length - 1];

  List<Shape> get shapes => _shapes;

  void deleteShapesAt(Offset p) {
    _shapes = _shapes
        .where((element) => !(element.getBoundaries().inflate(10).contains(p) &&
            element.collidesWithCircle(p, 10)))
        .toList();
    notifyListeners();
  }

  void apply(void Function(ImageModel) action) {
    action(this);
    notifyListeners();
  }
}
