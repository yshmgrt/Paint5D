import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paint5d/models/image_model.dart';
import 'package:paint5d/widgets/draw_page.dart';
import 'package:paint5d/widgets/name_dialog.dart';

class DrawList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawListState();
}

class DrawListState extends State<DrawList> {
  final List<File> draws = [];

  DrawListState() {
    loadFiles();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Paint 5D"),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (context, i) {
                return Container(
                    child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      new DrawPage(draws[i]))),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(draws[i].path.split("/").last)))),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          draws[i].delete();
                          draws.removeAt(i);
                        });
                      })
                ]));
              },
              itemCount: draws.length,
            )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () {
            showDialog<String>(
                context: context,
                builder: (context) => EnterNameDialog()).then((name) {
              ImageModel.createNew(name).then((file) {
                if (file != null)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new DrawPage(file)));
              });
            });
          },
        ),
      );

  void loadFiles() async {
    List<File> files = await ImageModel.loadFiles();
    setState(() {
      draws.clear();
      draws.addAll(files);
    });
  }
}
