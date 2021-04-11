import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:paint5d/models/image_model.dart';
import 'package:paint5d/widgets/paint_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<ui.Image> getImage(BuildContext context) async {
  ImageModel image = context.read<ImageModel>();

  Painter painter = Painter(image);
  ui.PictureRecorder recorder = ui.PictureRecorder();
  Canvas canvas = Canvas(recorder);
  Size imageSize = image.getSize();
  painter.paint(canvas, imageSize);
  return recorder
      .endRecording()
      .toImage(imageSize.width.floor(), imageSize.height.floor());
}

void saveImage(BuildContext context) async {
  ui.Image image = await getImage(context);
  var bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  var file = File((await getApplicationDocumentsDirectory()).path + "/tmp.png")..writeAsBytes(bytes.buffer.asUint8List());
  await ImageGallerySaver.saveFile(file.path);
  log("saved");
}