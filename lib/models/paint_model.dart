import 'package:flutter/material.dart';

class PaintModel with ChangeNotifier {
  Paint _paint = Paint();

  Paint get paint => _paint;

  double get size => _paint.strokeWidth;

  Color get color => _paint.color;

  Paint _createPaint(Color color, double size) {
    return Paint()
      ..color = color
      ..strokeWidth = size;
  }

  set color(Color color) {
    _paint = _createPaint(color, _paint.strokeWidth);
    notifyListeners();
  }

  set size(double size) {
    _paint = _createPaint(color, size);
    notifyListeners();
  }
}
