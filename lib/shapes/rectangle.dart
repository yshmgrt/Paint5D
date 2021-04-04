import 'package:flutter/material.dart';
import 'package:paint5d/shapes/shape.dart';
import 'package:paint5d/image.dart' as im;
import 'package:paint5d/action.dart' as act;

class Rectangle implements Shape {
  Offset topLeft;
  Offset bottomRight;

  Rectangle(Offset topLeft, Offset bottomRight) {
    this.topLeft = topLeft;
    this.bottomRight = bottomRight;
  }

  @override
  void draw(Canvas canvas, Paint paint) {
    canvas.drawRect(
        Rect.fromLTRB(topLeft.dx, topLeft.dy, bottomRight.dx, bottomRight.dy),
        paint);
  }

  void setBottomRight(Offset bottomRight) {
    this.bottomRight = bottomRight;
  }
}

class DrawRectangleAction implements act.Action {
  @override
  final act.ActionData data = act.ActionData("Draw rectangle", Icons.crop_square);

  @override
  void onPanDown(im.Image image, DragDownDetails details) {
    image.addShape(Rectangle(details.localPosition, details.localPosition));
  }

  @override
  void onPanEnd(im.Image image, DragEndDetails details) {}

  @override
  void onPanUpdate(im.Image image, DragUpdateDetails details) {
    Shape last = image.getLastShape();
    if (last is Rectangle) {
      last.setBottomRight(details.localPosition);
    }
  }
}