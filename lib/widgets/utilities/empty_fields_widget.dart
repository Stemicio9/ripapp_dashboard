import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class EmptyFieldsWidget{
  emptyFields(Function() onTap, {String text = "Svuota campi"}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Texth4V2(
          testo: text,
          color: background,
          weight: FontWeight.w600,
          underline: true,
        ),
      ),
    );
  }
}
