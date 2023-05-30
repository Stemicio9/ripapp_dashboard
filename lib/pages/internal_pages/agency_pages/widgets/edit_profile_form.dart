import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/images_constants.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/action_button.dart';
import '../../../../widgets/input.dart';

class EditProfileForm extends StatelessWidget{

  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  final dynamic nameValidator;
  final dynamic lastNameValidator;
  final dynamic phoneValidator;
  final dynamic emailValidator;
  final onTap;
  final imageOnTap;
  final File? imageFile;


  const EditProfileForm({
    super.key,
    this.imageFile,
    required this.imageOnTap,
    required this.onTap,
    required this.cardTitle,
    this.nameValidator,
    this.lastNameValidator,
    this.phoneValidator,
    this.emailValidator,
    required this.nameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 900,
            child: DialogCard(
                cancelIcon: true,
                paddingLeft: 10,
                paddingRight: 10,
                cardTitle: cardTitle,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5),
                                    child: Text(
                                      'FOTO',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: imageOnTap,
                                      child: Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                                          color: greyDrag,
                                          border: Border.all(color: background, width: 1),
                                          image: imageFile != null ?
                                          DecorationImage(
                                            image: FileImage(imageFile!),
                                            fit: BoxFit.contain,
                                          ) : DecorationImage(
                                            image: AssetImage(ImagesConstants.imgProductPlaceholder),
                                            fit: BoxFit.cover,

                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            )),

                        Expanded(
                            flex: 2,
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
                                  hinttext: getCurrentLanguageValue(NAME) ?? "",
                                  controller: nameController,
                                  validator: nameValidator,
                                  paddingLeft: 0,
                                  paddingRight: 20,
                                  borderSide: const BorderSide(color: greyState),
                                  activeBorderSide: const BorderSide(color: background),
                                ),

                                Padding(
                                  padding: getPadding(bottom: 5,top: 20),
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
                                  hinttext: getCurrentLanguageValue(EMAIL) ?? "",
                                  controller: emailController,
                                  validator: emailValidator,
                                  paddingRight: 20,
                                  paddingLeft: 0,
                                  borderSide: const BorderSide(color: greyState),
                                  activeBorderSide: const BorderSide(color: background),
                                )

                              ],
                            )),

                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(bottom: 5),
                                  child: Text(
                                    'COGNOME',
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: background,
                                    ),
                                  ),
                                ),
                                InputsV2Widget(
                                  hinttext: getCurrentLanguageValue(LAST_NAME) ?? "",
                                  controller: lastNameController,
                                  validator: lastNameValidator,
                                  paddingLeft: 0,
                                  paddingRight: 0,
                                  borderSide: const BorderSide(color: greyState),
                                  activeBorderSide: const BorderSide(color: background),
                                ),

                                Padding(
                                  padding: getPadding(bottom: 5,top: 20),
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
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ], // O,
                                  keyboard: TextInputType.number,
                                  paddingRight: 0,
                                  paddingLeft: 0,
                                  borderSide: const BorderSide(color: greyState),
                                  activeBorderSide: const BorderSide(color: background),
                                )

                              ],
                            )),
                      ],
                    ),
                    Padding(
                      padding: getPadding(top: 40),
                      child: Align(
                        alignment: Alignment.center,
                        child: ActionButtonV2(
                          maxWidth: 150,
                          action: onTap,
                          text: getCurrentLanguageValue(SAVE)!,
                        ),
                      ),
                    )
                  ],
                )
            ),
          )
        ],
      ),
    );
  }

}