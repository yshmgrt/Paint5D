import 'package:flutter/material.dart';
import 'package:paint5d/actions/action.dart' as act;
import 'package:paint5d/models/action_model.dart';
import 'package:paint5d/models/image_model.dart' as im;
import 'package:paint5d/shapes/shape.dart';
import 'package:provider/provider.dart';

class PaintWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    act.Action action = context.watch<ActionModel>().currentAction;
    return Consumer<im.ImageModel>(
        builder: (context, value, child) => GestureDetector(
              child: Container(
                width: double.infinity,
                child: CustomPaint(
                  painter: Painter(value),
                ),
              ),
              onPanDown: (d) => value.apply((im) {
                if (context.size.contains(d.localPosition)) {
                  action.onPanDown(im, d);
                }
              }),
              onPanUpdate: (d) => value.apply((im) {
                if (context.size.contains(d.localPosition)) {
                  action.onPanUpdate(im, d);
                }
              }),
            ));
  }
}

class Painter extends CustomPainter {
  im.ImageModel image;

  Painter(this.image) {
    this.image = image;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color=Colors.white);
    for (Shape s in image.shapes) {
      s.draw(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
