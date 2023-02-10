import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';


class DeleteMessageDialog extends StatelessWidget {

  final onConfirm;
  final onCancel;
  final String message;

  const DeleteMessageDialog({super.key, required this.onConfirm, required this.onCancel, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: getPadding(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: DialogCard(
                cardTitle:getCurrentLanguageValue(ATTENTION)!,
                child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: black,
                    )),
              ),
            ),


            Padding(
              padding: getPadding(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: getPadding(right: 3),
                    child: ActionButtonV2(
                      action: onConfirm,
                      text: getCurrentLanguageValue(CANCEL)!,
                      color: white,
                      textColor: background,
                      maxWidth: 225,
                      borderRadius: 10,

                    ),
                  ),
                  Padding(
                    padding: getPadding(left: 3),
                    child: ActionButtonV2(
                      action: onConfirm,
                      text: getCurrentLanguageValue(CONFIRM)!,
                      color: background,
                      maxWidth: 225,
                      borderRadius: 10,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
