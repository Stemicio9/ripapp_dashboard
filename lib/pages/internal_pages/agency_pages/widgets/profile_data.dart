import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/input.dart';

class ProfileData extends StatelessWidget {
  var imageFile;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController lastNameController;
  final TextEditingController phoneNumberController;
  final dynamic nameValidator;
  final dynamic emailValidator;
  final dynamic lastNameValidator;
  final dynamic phoneNumberValidator;

  ProfileData({
    this.imageFile,
    required this.nameController,
    this.nameValidator,
    required this.emailController,
    this.emailValidator,
    required this.lastNameController,
    this.lastNameValidator,
    required this.phoneNumberController,
    this.phoneNumberValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
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
                  Container(
                    height: 137,
                    width: 137,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(3)),
                        color: greyDrag,
                        border: Border.all(
                          color: background,
                          width: 1,
                        ),
                        image: imageFile != null ?




                        DecorationImage(
                          image: NetworkImage(imageFile),
                          fit: BoxFit.cover,
                        ) : DecorationImage(
                          image: AssetImage(ImagesConstants.imgDemisePlaceholder),
                          fit: BoxFit.cover,
                        ),
                    ),
                  ),
                ],
              )
          ),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'NOME',
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: background,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  InputsV2Widget(
                    mouseCursor: SystemMouseCursors.basic,
                    hinttext: getCurrentLanguageValue(NAME) ?? "",
                    controller: nameController,
                    validator: nameValidator,
                    paddingLeft: 0,
                    borderSide: const BorderSide(
                      color: greyState,
                    ),
                    activeBorderSide: const BorderSide(
                      color: greyState,
                    ),
                    readOnly: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      'EMAIL',
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: background,
                      ),
                    ),
                  ),
                  InputsV2Widget(
                    mouseCursor: SystemMouseCursors.basic,
                    hinttext: getCurrentLanguageValue(EMAIL) ?? "",
                    controller: emailController,
                    validator: emailValidator,
                    paddingLeft: 0,
                    borderSide: const BorderSide(
                      color: greyState,
                    ),
                    activeBorderSide: const BorderSide(
                      color: greyState,
                    ),
                    readOnly: true,
                  ),
                ],
              )),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'COGNOME',
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14,
                        color: background,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InputsV2Widget(
                    mouseCursor: SystemMouseCursors.basic,
                    hinttext: getCurrentLanguageValue(LAST_NAME)?? "",
                    controller: lastNameController,
                    validator: lastNameValidator,
                    paddingLeft: 0,
                    borderSide: const BorderSide(
                      color: greyState,
                    ),
                    activeBorderSide: const BorderSide(
                      color: greyState,
                    ),
                    readOnly: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      'TELEFONO',
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: background,
                      ),
                    ),
                  ),
                  InputsV2Widget(
                    mouseCursor: SystemMouseCursors.basic,
                    hinttext: getCurrentLanguageValue(PHONE_NUMBER)?? "",
                    controller: phoneNumberController,
                    validator: phoneNumberValidator,
                    paddingLeft: 0,
                    borderSide: const BorderSide(
                      color: greyState,
                    ),
                    activeBorderSide: const BorderSide(
                      color: greyState,
                    ),
                    readOnly: true,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
