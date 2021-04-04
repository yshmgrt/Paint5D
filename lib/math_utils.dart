import 'dart:math';
import 'package:flutter/material.dart';

class Line {
  Offset a;
  Offset b;
  double get dx => b.dx - a.dx;
  double get dy => b.dy - a.dy;
  double get len => distance(a, b);
  Line.fromPoints(this.a, this.b);
  double operator *(Line other) => dx * other.dx + dy * other.dy;
}

double sqr(double a) {
  return a * a;
}

double distance(Offset a, Offset b) {
  return sqrt(sqr(a.dx - b.dx) + sqr(a.dy - b.dy));
}

double distanceToLine(Offset p, Line l) {
  double a = l.a.dy - l.b.dy;
  double b = - l.a.dx + l.b.dx;
  double c = - a * l.a.dx - b * l.a.dy;
  return (a * p.dx + b * p.dy + c).abs() / sqrt(sqr(a) + sqr(b));
}

double distanceToSegment(Offset p, Line l) {
  var ab = Line.fromPoints(l.a, l.b);
  var ap = Line.fromPoints(l.a, p);
  var bp = Line.fromPoints(l.b, p);
  if (ab * ap > 0 && ab * bp < 0) {
    return distanceToLine(p, l);
  }
  return min(distance(p, l.a), distance(p, l.b));
}