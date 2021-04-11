import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:paint5d/actions/action.dart' as act;
import 'package:paint5d/models/action_model.dart';
import 'package:paint5d/widgets/action_button.dart';
import 'package:provider/provider.dart';

class Toolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<ActionModel>(
      builder: (context, provider, child) => BottomAppBar(
            child: Row(
              children: [
                ...provider.actions.mapIndexed((i, e) => ActionButton(
                      actionData: e.data,
                      onPressed: () => provider.currentAction = e,
                      isSelected: provider.isCurrentAction(i),
                    )),
                ActionButton(
                  actionData:
                      new act.ActionData("Open color picker", Icons.color_lens),
                  onPressed: () => provider.toggleColorPanelOpened(),
                  isSelected: provider.isColorPanelOpened,
                ),
              ],
            ),
          ));
}
