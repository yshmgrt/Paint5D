import 'package:flutter/material.dart';
import 'package:paint5d/models/action_model.dart';
import 'package:paint5d/widgets/color_picker.dart';
import 'package:paint5d/widgets/paint_widget.dart';
import 'package:paint5d/widgets/toolbar.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Paint 5D',
        home: Scaffold(
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
        ),
      );
}




