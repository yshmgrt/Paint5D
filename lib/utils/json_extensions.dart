import 'package:flutter/material.dart';

extension JsonableOffset on Offset {
  Map<String, dynamic> toJson() => {
        "x": dx,
        "y": dy,
      };

  static Offset fromJson(Map<String, dynamic> json) =>
      Offset(json["x"], json["y"]);
}

extension JsonablePaint on Paint {
  Map<String, dynamic> toJson() => {
        "color": color.value,
        "size": strokeWidth,
      };

  static Paint fromJson(Map<String, dynamic> json) => Paint()
    ..color = Color(json["color"])
    ..strokeWidth = json["size"];
}
