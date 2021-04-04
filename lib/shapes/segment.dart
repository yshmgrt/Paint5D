import 'package:flutter/material.dart';
import 'package:paint5d/shapes/shape.dart';
import 'package:paint5d/image.dart' as im;
import 'package:paint5d/action.dart' as act;

class Segment implements Shape {
  Offset from;
  Offset to;

  Segment(Offset from, Offset to) {

    this.from = from;
    this.to = to;
  }

  @override
  void draw(Canvas canvas, Paint paint) {
    canvas.drawLine(from, to, paint);
  }

  void setTo(Offset to) {
    this.to = to;
  }
}

class DrawSegmentAction implements act.Action {
  @override
  final act.ActionData data = act.ActionData("Draw segment", Icons.minimize);

  @override
  void onPanDown(im.Image image, DragDownDetails details) {
    image.addShape(Segment(details.localPosition, details.localPosition));
  }

  @override
  void onPanEnd(im.Image image, DragEndDetails details) {}

  @override
  void onPanUpdate(im.Image image, DragUpdateDetails details) {
    Shape last = image.getLastShape();
    if (last is Segment) {
      last.setTo(details.localPosition);
    }
  }
}
