import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paint5d/models/action_model.dart';
import 'package:paint5d/models/image_model.dart';
import 'package:paint5d/models/paint_model.dart';
import 'package:paint5d/shapes/shape_factory.dart';
import 'package:paint5d/utils/image_utils.dart';
import 'package:paint5d/widgets/color_picker.dart';
import 'package:paint5d/widgets/paint_widget.dart';
import 'package:paint5d/widgets/toolbar.dart';
import 'package:provider/provider.dart';

class DrawPage extends StatelessWidget {
  final File currentFile;

  DrawPage(this.currentFile);

  @override
  Widget build(BuildContext context) {
    ImageModel imageModel = ImageModel();
    imageModel.readFile(currentFile);
    ShapeFactory factory = ShapeFactory();
    PaintModel paintModel = PaintModel();
    paintModel.addListener(() {
      factory.paint = paintModel.paint;
    });
    paintModel.size = 1.0;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ImageModel>.value(value: imageModel),
          ChangeNotifierProvider<PaintModel>.value(value: paintModel),
          ChangeNotifierProvider<ActionModel>.value(
              value: ActionModel(factory)),
        ],
        builder: (context, child) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Provider.of<ImageModel>(context, listen: false)
                        .save(currentFile);
                    Navigator.pop(context);
                  },
                ),
                title: Text(currentFile.path.split("/").last),
                actions: [
                  IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () => saveImage(context))
                ],
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PaintWidget(),
                      flex: 1,
                    ),
                    if (context.watch<ActionModel>().isColorPanelOpened)
                      ColorPicker(),
                    Toolbar(),
                  ],
                ),
              ),
            ));
  }
}
