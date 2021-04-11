import 'package:flutter/material.dart';

class EnterNameDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EnterNameDialogState();
}

class EnterNameDialogState extends State<EnterNameDialog> {
  String name = "";

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text("Enter name"),
    content: TextField(
      onChanged: (value) => setState(() {
        name = value;
      }),
    ),
    actions: [
      MaterialButton(
        onPressed: () {
          Navigator.pop(context, null);
        },
        child: Text("Cancel"),
      ),
      MaterialButton(
        onPressed: () {
          Navigator.pop(context, name);
        },
        child: Text("Ok"),
      )
    ],
  );
}
