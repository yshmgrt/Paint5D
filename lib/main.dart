import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Paint 5D',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Text(""),
    );
}