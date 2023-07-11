import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/tooltip_widget.dart';

class ActionWidget extends StatelessWidget {
  final ActionDefinition action;

  const ActionWidget({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
            Function.apply(action.action, action.actionInputs);
           // action.action(action.actionInputs);
        },
        child: action.isButton
            ? SuperiorActionWidget(action: action.action, text: action.text, buttonColor: action.buttonColor)
            : IconTableWidget(icon: action.icon, tooltip: action.tooltip),
      ),
    );
  }
}

class IconTableWidget extends StatelessWidget {
  final IconData icon;
  final String tooltip;

  const IconTableWidget({Key? key, required this.icon, required this.tooltip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TooltipWidget(
        message: tooltip,
        direction: AxisDirection.down,
        child: Icon(icon, color: background, size: 24));
  }
}

class SuperiorActionWidget extends StatelessWidget {
  final String text;
  final Function action;
  final Color buttonColor;

  const SuperiorActionWidget({Key? key,
    required this.text,
    required this.action,
    this.buttonColor = background}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButtonV2(
        action: action,
        color: buttonColor,
        text: text,
        fontSize: 14,
        containerHeight: 35,
    );
  }
}
