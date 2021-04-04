import 'package:flutter/material.dart';
import 'package:paint5d/action.dart' as act;
import 'package:paint5d/paint_widget.dart';
import 'package:paint5d/shapes/line.dart';
import 'package:paint5d/shapes/rectangle.dart';
import 'package:paint5d/shapes/segment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static final List<act.Action> actions = [
    DrawLineAction(),
    DrawRectangleAction(),
    DrawSegmentAction(),
  ];

  act.Action currentAction = DrawLineAction();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Paint 5D',
        home: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child:
                      Container(width: double.infinity, child: PaintWidget(currentAction)),
                ),
                Row(
                  children: actions
                      .map((e) => IconButton(
                          icon: Icon(e.data.icon),
                          onPressed: () => setState(() {
                                currentAction = e;
                              })))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      );
}