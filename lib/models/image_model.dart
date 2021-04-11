import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paint5d/shapes/shape.dart';
import 'package:paint5d/shapes/shape_factory.dart';
import 'package:path_provider/path_provider.dart';

class ImageModel with ChangeNotifier {
  List<Shape> _shapes = [];
  
  List<Shape> get shapes => _shapes;
  set shapes(List<Shape> src) {
    _shapes = src;
    notifyListeners();
  }

  ImageModel();

  void addShape(Shape s) {
    _shapes.add(s);
    notifyListeners();
  }

  Shape get currentShape => _shapes[_shapes.length - 1];
  
  void deleteShapesAt(Offset p) {
    _shapes = _shapes
        .where((element) => !(element.getBoundaries().inflate(10).contains(p) &&
            element.collidesWithCircle(p, 10)))
        .toList();
    notifyListeners();
  }

  void apply(void Function(ImageModel) action) {
    action(this);
    notifyListeners();
  }

  Size getSize() => _shapes
      .map((e) => e.getBoundaries())
      .fold(
          Rect.zero,
          (Rect previousValue, element) =>
              previousValue.expandToInclude(element))
      .inflate(20)
      .size;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> res = {
      "data": _shapes.map((e) => e.toJson()).toList(),
    };
    return res;
  }

  List<Shape> fromJson(Map<String, dynamic> map) {
    return (map["data"] as List<dynamic>)
        .map((e) => ShapeFactory.fromJson(e))
        .toList();
  }

  void save(File file) async {
    file.writeAsString(jsonEncode(toJson()));
  }

  void readFile(File file) async {
    _shapes = [];
    String json = await file.readAsString();
    _shapes = fromJson(jsonDecode(json));
    notifyListeners();
  }

  static Future<List<File>> loadFiles() async {
    Directory path = await getApplicationDocumentsDirectory();
    return await path
        .list()
        .where((event) => event is File)
        .map((event) => event as File)
        .where((event) => event.path.endsWith(".im"))
        .toList();
  }

  static Future<File> createNew(String name) async {
    if (name == null) {
      return null;
    }
    Directory path = await getApplicationDocumentsDirectory();
    File curr = File(path.path + "/" + name + ".im");
    await curr.writeAsString("");
    loadFiles();
    return curr;
  }
}
