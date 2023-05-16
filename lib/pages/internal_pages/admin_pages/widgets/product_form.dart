import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/input.dart';

import '../../../../widgets/texts.dart';

class ProductForm extends StatelessWidget {
  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;

  final dynamic nameValidator;
  final dynamic priceValidator;
  final dynamic descriptionValidator;
  final onTap;
  final imageOnTap;
  final File? imageFile;


  const ProductForm({
    super.key,
    this.imageFile,
    required this.imageOnTap,
    required this.onTap,
    required this.cardTitle,
    this.nameValidator,
    this.descriptionValidator,
    this.priceValidator,
    required this.nameController,
    required this.descriptionController,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(left: 100, right: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DialogCard(
              cancelIcon: true,
              paddingLeft: 10,
              paddingRight: 10,
              cardTitle: cardTitle,
              child: Column(
                children: [
                  Row(
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
                                  paddingRight: 15,
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
                                  padding: getPadding(bottom: 5,left: 6),
                                  child: Text(
                                    'PREZZO',
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: background,
                                    ),
                                  ),
                                ),
                                InputsV2Widget(
                                  hinttext: getCurrentLanguageValue(PRICE)!,
                                  controller: priceController,
                                  validator: priceValidator,
                                  inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                  ], // O,
                                  keyboard: TextInputType.number,
                                  paddingRight: 0,
                                  paddingLeft: 15,
                                  borderSide: const BorderSide(color: greyState),
                                  activeBorderSide: const BorderSide(color: background),
                                )
                              ],
                            )),

                        /*    Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(bottom: 5),
                                  child: Text(
                                    'DESCRIZIONE',
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: background,
                                    ),
                                  ),
                                ),
                                InputsV2Widget(
                                  hinttext: getCurrentLanguageValue(DESCRIPTION)!,
                                  controller: descriptionController,
                                  validator: descriptionValidator,
                                  paddingLeft: 0,
                                  borderSide: const BorderSide(color: greyState),
                                  activeBorderSide: const BorderSide(color: background),
                                )
                              ],
                            )), */
                      ],
                    ),



                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(bottom: 5),
                                  child: Text(
                                    'FOTO PRODOTTO',
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
                                    height: height*0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                                      color: greyDrag,
                                      border: Border.all(color: background, width: 1),
                                      image: imageFile != null ?
                                      DecorationImage(
                                        image: FileImage(imageFile!),
                                        fit: BoxFit.contain,
                                      )
                                          : null,
                                    ),
                                    child: imageFile == null ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Texth2V2(
                                          testo:getCurrentLanguageValue(INSERT_PHOTO) ?? "",
                                          color: greyDisabled,
                                          weight: FontWeight.bold,
                                          textalign: TextAlign.center,

                                        ),
                                      ),
                                    ) : const SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex:1,child: Container()),
                      ],

                    ),
                  ),


                  Align(
                    alignment: Alignment.centerRight,
                    child: ActionButtonV2(
                      action: onTap,
                      text: getCurrentLanguageValue(SAVE)!,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
