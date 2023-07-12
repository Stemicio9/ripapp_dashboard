

import 'package:flutter/material.dart';

abstract class TableRowElement{
  List<String> getHeaders();
  List<RowElement> rowElements();
}


class RowElement {
  final bool isText;
  final bool isImage;
  final bool isIcon;
  // TODO change to dynamic or a specific interface to make it more generic
  final String element;
  final IconData? iconData;
  final Color? color;

  RowElement({required this.isText, required this.isImage, required this.element, required this.isIcon,
  this.iconData, this.color});


}