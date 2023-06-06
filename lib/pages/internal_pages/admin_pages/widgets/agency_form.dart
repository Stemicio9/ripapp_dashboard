import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/input.dart';

class AgencyForm extends StatelessWidget {
  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController cityController;
  final dynamic nameValidator;
  final dynamic cityValidator;
  final dynamic emailValidator;
  final dynamic phoneValidator;
  final Function() onSubmit;

  const AgencyForm({
    super.key,
    required this.cardTitle,
    this.nameValidator,
    this.emailValidator,
    this.phoneValidator,
    this.cityValidator,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.cityController,
    required this.onSubmit
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 700,
            child: DialogCard(
                cancelIcon: true,
                paddingLeft: 10,
                paddingRight: 10,
                cardTitle: cardTitle,
                child: Column(
                  children: [
                    Padding(
                      padding: getPadding(bottom: 30),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5),
                                    child: Text(
                                      'NOME',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                  InputsV2Widget(
                                    hinttext: getCurrentLanguageValue(NAME)!,
                                    controller: nameController,
                                    validator: nameValidator,
                                    paddingLeft: 0,
                                    paddingRight: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5,left: 3),
                                    child: Text(
                                      'CITTÀ',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                  InputsV2Widget(
                                    hinttext: getCurrentLanguageValue(CITY)!,
                                    controller: cityController,
                                    validator: cityValidator,
                                    paddingRight: 0,
                                    paddingLeft: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(bottom: 40),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5),
                                    child: Text(
                                      'EMAIL',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                  InputsV2Widget(
                                    hinttext: getCurrentLanguageValue(EMAIL)!,
                                    controller: emailController,
                                    validator: emailValidator,
                                    paddingLeft: 0,
                                    paddingRight: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5,left: 3),
                                    child: Text(
                                      'TELEFONO',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                  InputsV2Widget(
                                    hinttext: getCurrentLanguageValue(PHONE_NUMBER)!,
                                    controller: phoneController,
                                    validator: phoneValidator,
                                    paddingRight: 0,
                                    paddingLeft: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ActionButtonV2(
                      action: onSubmit,
                      text: getCurrentLanguageValue(SAVE)!,
                    ),
                  )
                ],
              )))
        ],
      ),
    );
  }
}