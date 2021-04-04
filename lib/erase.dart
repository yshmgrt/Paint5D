import 'package:flutter/material.dart';
import 'package:paint5d/action.dart' as act;
import 'package:paint5d/image.dart' as im;

class EraseAction implements act.Action {
  @override
  final act.ActionData data = act.ActionData("Erase", Icons.healing);

  @override
  void onPanDown(im.Image image, DragDownDetails details) {}

  @override
  void onPanEnd(im.Image image, DragEndDetails details) {}

  @override
  void onPanUpdate(im.Image image, DragUpdateDetails details) {
    image.deleteShapesAt(details.localPosition);
  }

}