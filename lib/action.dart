import 'package:flutter/material.dart';
import 'package:paint5d/image.dart' as im;

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

  void onPanDown(im.Image image, DragDownDetails details);

  void onPanUpdate(im.Image image, DragUpdateDetails details);

  void onPanEnd(im.Image image, DragEndDetails details);
}





