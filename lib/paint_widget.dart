import 'package:flutter/material.dart';

class PaintWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PaintWidgetState();
}

class PaintWidgetState extends State<PaintWidget> {
  List<Shape> image = [];

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: CustomPaint(
          painter: Painter(image),
        ),
        onPanDown: (d) => setState(() {
          image.add(Shape());
        }),
        onPanUpdate: (d) => setState(() {
          image[image.length - 1].points.add(d.localPosition);
        }),
      );
}

class Painter extends CustomPainter {
  List<Shape> image;

  Painter(List<Shape> image) {
    this.image = image;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    for (Shape s in image) {
      for (int i = 0; i < s.points.length - 1; i++) {
        canvas.drawLine(
            s.points[i],
            s.points[i + 1],
            paint
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Shape {
  List<Offset> points = [];

  void addPoint(Offset p) {
    points.add(p);
  }
}
