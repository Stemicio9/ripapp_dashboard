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


class EditProfileForm extends StatefulWidget{


  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  final dynamic nameValidator;
  final dynamic lastNameValidator;
  final dynamic phoneValidator;
  final dynamic emailValidator;
  final Function() onTap;
  bool showConfirmPassword;
  final Function() imageOnTap;
  final Function() changePassword;
  final File? imageFile;


   EditProfileForm({
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
    this.showConfirmPassword = false,
    required this.changePassword
  });

  @override
  State<StatefulWidget> createState() {
    return EditProfileFormState();
  }

}



class EditProfileFormState extends State<EditProfileForm>{




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
                cardTitle: widget.cardTitle,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child:  Column(
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
                                      onTap: widget.imageOnTap,
                                      child: Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                                          color: greyDrag,
                                          border: Border.all(color: background, width: 1),
                                          image: widget.imageFile != null ? DecorationImage(
                                            image: FileImage(widget.imageFile!),
                                            fit: BoxFit.contain,
                                          ) : DecorationImage(
                                            image: AssetImage(ImagesConstants.imgDemisePlaceholder),
                                            fit: BoxFit.cover,

                                          ),
                                        ),
                                      ))
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
                                  controller: widget.nameController,
                                  validator: widget.nameValidator,
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
                                  controller: widget.emailController,
                                  validator: widget.emailValidator,
                                  paddingRight: 20,
                                  paddingLeft: 0,
                                  borderSide: const BorderSide(color: greyState),
                                  activeBorderSide: const BorderSide(color: background),
                                ),

                                Padding(
                                  padding: getPadding(bottom: 5,top: 20),
                                  child: Text(
                                    'CAMBIA PASSWORD',
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: background,
                                    ),
                                  ),
                                ),



                                Visibility(
                                  visible: !widget.showConfirmPassword,
                                  child: ActionButtonV2(
                                      action: (){
                                        setState(() {
                                          widget.showConfirmPassword = true;
                                        });
                                      },
                                      text: "Reset password",
                                    fontSize: 14,
                                    containerHeight: 35,
                                  ),
                                ),

                                Visibility(
                                  visible: widget.showConfirmPassword,
                                    child: Row(
                                      children: [

                                        Padding(
                                          padding: getPadding(right:6.5),
                                          child: ActionButtonV2(
                                            action: (){
                                              setState(() {
                                                widget.showConfirmPassword = false;
                                              });
                                            },
                                            text: getCurrentLanguageValue(CANCEL) ?? "",
                                            maxWidth: 100,
                                            fontSize: 14,
                                            containerHeight: 35,
                                            borderColor: background,
                                            textColor: background,
                                            color: white,
                                            hasBorder: true,

                                          ),
                                        ),

                                        ActionButtonV2(
                                          action: widget.changePassword,
                                          text: getCurrentLanguageValue(CONFIRM) ?? "",
                                          maxWidth: 100,
                                          fontSize: 14,
                                          containerHeight: 35,

                                        ),
                                      ],
                                    )
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
                                  controller: widget.lastNameController,
                                  validator: widget.lastNameValidator,
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
                                  controller: widget.phoneController,
                                  validator: widget.phoneValidator,
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
                        alignment: Alignment.centerRight,
                        child: ActionButtonV2(
                          action: widget.onTap,
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