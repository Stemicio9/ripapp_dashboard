


import 'package:flutter/material.dart';

class ActionDefinition {

  final Function action;
  dynamic actionInputs;
  final IconData icon;
  final String text;
  final bool isButton;
  final String tooltip;


  // default is not a button, is an icon action (right side of table row)
  ActionDefinition({required this.action,
    this.icon = Icons.add, this.text = "",
    this.isButton = false, this.tooltip = "", this.actionInputs});
}


