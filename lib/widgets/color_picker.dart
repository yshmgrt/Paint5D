import 'package:flutter/material.dart';
import 'package:paint5d/models/paint_model.dart';
import 'package:provider/provider.dart';

class ColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8,
            blurRadius: 8,
            offset: Offset(0, 8),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Consumer<PaintModel>(
          builder: (context, value, child) => Container(
                child: Column(children: [
                  ValueSlider(
                    colorName: "R",
                    value: value.color.red.toDouble(),
                    onChanged: (r) =>
                        {value.color = value.color.withRed(r.toInt())},
                    maxValue: 255,
                  ),
                  ValueSlider(
                      colorName: "G",
                      value: value.color.green.toDouble(),
                      onChanged: (g) =>
                          {value.color = value.color.withGreen(g.toInt())},
                      maxValue: 255),
                  ValueSlider(
                      colorName: "B",
                      value: value.color.blue.toDouble(),
                      onChanged: (b) =>
                          {value.color = value.color.withBlue(b.toInt())},
                      maxValue: 255),
                  ValueSlider(
                    colorName: "Width",
                    value: value.size,
                    onChanged: (s) => {value.size = s},
                    minValue: 1,
                  ),
                ]),
              )));
}

class ValueSlider extends StatelessWidget {
  final String colorName;
  final double value;
  final Function(double) onChanged;
  final double minValue;
  final double maxValue;

  ValueSlider(
      {@required this.onChanged,
      this.colorName = "",
      this.value = 0,
      this.minValue = 0,
      this.maxValue = 100});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: Text(colorName.padRight(10)),
          ),
          Expanded(
            child: Slider(
              min: minValue,
              max: maxValue,
              value: value,
              onChanged: onChanged,
            ),
            flex: 1,
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Text(value.toInt().toString().padRight(10)),
          ),
        ],
      );
}
