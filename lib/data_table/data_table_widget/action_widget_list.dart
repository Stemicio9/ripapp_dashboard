

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action_widget.dart';

class ActionWidgetList extends StatelessWidget {

  final List<ActionDefinition> actions;
  const ActionWidgetList({Key? key, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...actions.map((e) => ActionWidget(action: e))
      ],
    );
  }
}
