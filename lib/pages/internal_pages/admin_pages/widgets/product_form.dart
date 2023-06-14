import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
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
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 600,
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
                                          ) : const DecorationImage(
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
                                  hinttext: getCurrentLanguageValue(NAME)!,
                                  controller: nameController,
                                  validator: nameValidator,
                                  paddingLeft: 0,
                                  paddingRight: 0,
                                  borderSide: const BorderSide(color: greyState),
                                  activeBorderSide: const BorderSide(color: background),
                                ),

                                Padding(
                                  padding: getPadding(bottom: 5,top: 20),
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
                          action: onTap,
                          text: getCurrentLanguageValue(SAVE)!,
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],

      ),
    );
  }
}
