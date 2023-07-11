import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class EmptyFieldsWidget{
  emptyFields(Function() onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Texth4V2(
          testo: getCurrentLanguageValue(EMPTY_FIELDS) ?? "",
          color: background,
          weight: FontWeight.w600,
          underline: true,
        ),
      ),
    );
  }
}
