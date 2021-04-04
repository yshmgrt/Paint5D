import 'package:flutter/material.dart';
import 'package:paint5d/shapes/shape.dart';
import 'package:paint5d/image.dart' as im;
import 'package:paint5d/action.dart' as act;

class PaintWidget extends StatefulWidget {
  final act.Action action;
  PaintWidget(this.action);

  @override
  State<StatefulWidget> createState() => PaintWidgetState();
}

class PaintWidgetState extends State<PaintWidget> {
  im.Image image = im.Image();

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: CustomPaint(
          painter: Painter(image),
        ),
        onPanDown: (d) => setState(() {
          widget.action.onPanDown(image, d);
        }),
        onPanUpdate: (d) => setState(() {
          widget.action.onPanUpdate(image, d);
        }),
        onPanEnd: (d) => setState(() {
          widget.action.onPanEnd(image, d);
        }),
      );
}

class Painter extends CustomPainter {
  im.Image image;

  Painter(im.Image image) {
    this.image = image;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style=PaintingStyle.stroke;
    for (Shape s in image.shapes) {
      s.draw(canvas, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
