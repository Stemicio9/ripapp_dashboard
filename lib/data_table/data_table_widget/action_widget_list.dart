import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action_widget.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';

class ActionWidgetList extends StatelessWidget {

  final List<ActionDefinition> actions;
  const ActionWidgetList({Key? key, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...actions.map((e) => Padding(
          padding: getPadding(right: 5),
          child: ActionWidget(action: e),
        ))
      ],
    );
  }
}
