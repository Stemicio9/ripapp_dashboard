import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/utilities/empty_fields_widget.dart';

class ProductFormButtons extends StatelessWidget{


  final Function() action;
  final Function() emptyFields;

  const ProductFormButtons({super.key, required this.action, required this.emptyFields});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: EmptyFieldsWidget().emptyFields(emptyFields),
        ),

        Expanded(
          flex: 1,
          child: Padding(
            padding: getPadding(top: 40),
            child: Align(
              alignment: Alignment.centerRight,
              child: ActionButtonV2(
                action: action,
                text: getCurrentLanguageValue(SAVE)!,
              ),
            ),
          ),
        ),
      ],
    );
  }

}