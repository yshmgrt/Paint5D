import 'package:flutter/material.dart';
import 'package:paint5d/actions/action.dart' as act;

class ActionButton extends StatelessWidget {
  final act.ActionData actionData;
  final Function onPressed;
  final bool isSelected;

  ActionButton(
      {@required this.actionData,
      @required this.onPressed,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) => Expanded(
      flex: 1,
      child: IconButton(
        color: isSelected ? Colors.accents[0] : Colors.black,
        tooltip: actionData.name,
        icon: Icon(actionData.icon),
        onPressed: onPressed,
      ));
}
