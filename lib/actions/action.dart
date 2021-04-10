import 'package:flutter/material.dart';
import 'package:paint5d/models/image_model.dart' as im;
import 'package:paint5d/shapes/shape_factory.dart';

@immutable
class ActionData {
  final String name;
  final IconData icon;

  ActionData(this.name, this.icon);
}

@immutable
abstract class Action {
  final ActionData data;

  Action(this.data);

  void onPanDown(im.ImageModel image, DragDownDetails details);

  void onPanUpdate(im.ImageModel image, DragUpdateDetails details);
}

@immutable
class CreateShapeAction extends Action {
  final ShapeFactory _shapeFactory;
  final ShapeType _shapeType;

  CreateShapeAction(ActionData data, this._shapeFactory, this._shapeType)
      : super(data);

  @override
  void onPanDown(im.ImageModel image, DragDownDetails details) {
    image
        .addShape(_shapeFactory.createShape(_shapeType, details.localPosition));
  }

  @override
  void onPanUpdate(im.ImageModel image, DragUpdateDetails details) {
    image.currentShape.update(details.localPosition);
  }
}
