import 'package:flutter/material.dart';
import 'package:paint5d/models/action_model.dart';
import 'package:paint5d/models/image_model.dart' as im;
import 'package:paint5d/models/paint_model.dart';
import 'package:paint5d/shapes/shape_factory.dart';
import 'package:paint5d/widgets/app.dart';
import 'package:provider/provider.dart';

void main() {
  ShapeFactory factory = ShapeFactory();
  PaintModel paintModel = PaintModel();
  paintModel.addListener(() {
    factory.paint = paintModel.paint;
  });
  paintModel.size = 1.0;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<im.ImageModel>.value(value: im.ImageModel()),
    ChangeNotifierProvider<PaintModel>.value(value: paintModel),
    ChangeNotifierProvider<ActionModel>.value(value: ActionModel(factory)),
  ], child: MyApp()));
}
