import 'package:flutter/material.dart';
import 'package:paint5d/paint_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Paint 5D',
        home: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(width: double.infinity, child: PaintWidget()),
                ),
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.edit), onPressed: () => {}),
                    IconButton(icon: Icon(Icons.healing), onPressed: () => {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}