import 'package:flutter/material.dart';
import 'package:paint5d/actions/action.dart' as act;
import 'package:paint5d/actions/erase.dart';
import 'package:paint5d/shapes/shape_factory.dart';

class ActionModel with ChangeNotifier {
  final List<act.Action> _actions;

  ActionModel(ShapeFactory shapeFactory)
      : _actions = [
          act.CreateShapeAction(act.ActionData("Draw line", Icons.edit),
              shapeFactory, ShapeType.LINE),
          act.CreateShapeAction(act.ActionData("Draw segment", Icons.minimize),
              shapeFactory, ShapeType.SEGMENT),
          act.CreateShapeAction(
              act.ActionData("Draw rectangle", Icons.crop_3_2),
              shapeFactory,
              ShapeType.RECTANGLE),
          EraseAction(),
        ];

  List<act.Action> get actions => _actions;

  int _currentActionIndex = 0;

  set currentAction(act.Action action) {
    int old = _currentActionIndex;
    _currentActionIndex = _actions.indexOf(action);
    if (_currentActionIndex == -1) {
      _currentActionIndex = old;
    }
    notifyListeners();
  }

  act.Action get currentAction {
    return _actions[_currentActionIndex];
  }

  bool isCurrentAction(int i) => i == _currentActionIndex;

  bool _isColorPanelOpened = false;

  bool get isColorPanelOpened => _isColorPanelOpened;

  void toggleColorPanelOpened() {
    _isColorPanelOpened = !_isColorPanelOpened;
    notifyListeners();
  }
}
