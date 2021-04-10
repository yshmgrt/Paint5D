import 'package:flutter/material.dart';
import 'package:paint5d/actions/action.dart' as act;
import 'package:paint5d/models/image_model.dart' as im;

class EraseAction implements act.Action {
  @override
  final act.ActionData data = act.ActionData("Erase", Icons.healing);

  @override
  void onPanDown(im.ImageModel image, DragDownDetails details) {
    _deleteShapes(image, details.localPosition);
  }

  @override
  void onPanUpdate(im.ImageModel image, DragUpdateDetails details) {
    _deleteShapes(image, details.localPosition);
  }

  void _deleteShapes(im.ImageModel image, Offset position) {
    image.deleteShapesAt(position);
  }
}
