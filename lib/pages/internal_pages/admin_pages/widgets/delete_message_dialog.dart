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
              width: 600,
              child: DialogCard(
                  cardTitle:getCurrentLanguageValue(ATTENTION)!,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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

                      Padding(
                        padding: getPadding(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Padding(
                              padding: getPadding(right: 3),
                              child: Expanded(
                                flex: 1,
                                child:  ActionButtonV2(
                                  action: onCancel,
                                  text: getCurrentLanguageValue(CANCEL)!,
                                  color: white,
                                  hasBorder: true,
                                  textColor: background,
                                  borderColor: background,
                                  maxWidth: 180,

                                ),
                              ),
                            ),

                            Padding(
                              padding: getPadding(left: 3),
                              child: Expanded(
                                flex: 1,
                                child:  ActionButtonV2(
                                    action: onConfirm,
                                    text: getCurrentLanguageValue(CONFIRM)!,
                                    color: background,
                                    maxWidth: 180,
                                ),
                                ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ),

          ],
        ));
  }
}
