


import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';

class ActionDefinition {

  final Function action;
  List<dynamic> actionInputs;
  final IconData icon;
  final String text;
  final Color buttonColor;
  final bool isButton;
  final String tooltip;


  // default is not a button, is an icon action (right side of table row)
  ActionDefinition({required this.action,
    this.icon = Icons.add, this.text = "",
    this.isButton = false, this.tooltip = "", required this.actionInputs,
    this.buttonColor = background});

   ActionDefinition copy(){
     return ActionDefinition(
         action: action,
         actionInputs: actionInputs,
         icon: icon,
          text: text,
          buttonColor: buttonColor,
          isButton: isButton,
          tooltip: tooltip
     );
   }
}


