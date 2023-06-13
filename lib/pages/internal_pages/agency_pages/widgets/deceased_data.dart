import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/widgets/autocomplete.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/language.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/input.dart';
import '../../../../widgets/texts.dart';

class DeceasedData extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController cityController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController dateController;
  final TextEditingController citiesController;
  final TextEditingController filterController;

  final dynamic nameValidator;
  final dynamic phoneValidator;
  final dynamic lastNameValidator;
  final dynamic ageValidator;
  final dynamic dateValidator;
  final iconOnTap;
  final imageOnTap;
  final onDragDone;
  final onDragUpdated;
  final onDragEntered;
  final onDragExited;
  final Widget child;
  final File? imageFile;
  final List<String> options;
  final List<String> citiesOfInterestOptions;

  const DeceasedData(
      {super.key,
        required this.imageOnTap,
        this.nameValidator,
        this.phoneValidator,
        this.lastNameValidator,
        this.ageValidator,
        this.dateValidator,
        required this.child,
        required this.onDragDone,
        required this.onDragEntered,
        required this.onDragExited,
        required this.onDragUpdated,
        required this.iconOnTap,
        required this.citiesController,
        required this.nameController,
        required this.phoneController,
        required this.cityController,
        required this.filterController,
        required this.lastNameController,
        required this.ageController,
        required this.options,
        required this.citiesOfInterestOptions,
        this.imageFile,
        required this.dateController});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Texth1V2(
                testo: "Dati defunto",
                color: background,
                weight: FontWeight.w700,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
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
                              height: 138,
                              width: 138,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(3)),
                                color: greyDrag,
                                border: Border.all(color: background, width: 1),
                                image: imageFile != null ?
                                DecorationImage(
                                  image: FileImage(imageFile!),
                                  fit: BoxFit.contain,
                                )
                                    : DecorationImage(
                                  image: AssetImage(ImagesConstants.imgDemisePlaceholder),
                              fit: BoxFit.cover,
                                )
                              ),
                          /*    child: imageFile == null ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Texth4V2(
                                    testo:getCurrentLanguageValue(INSERT_PHOTO) ?? "",
                                    color: greyDisabled,
                                    weight: FontWeight.bold,
                                    textalign: TextAlign.center,

                                  ),
                                ),
                              ) : const SizedBox(), */
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                            ],
                            hinttext: getCurrentLanguageValue(NAME)!,
                            controller: nameController,
                            validator: nameValidator,
                            paddingLeft: 0,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          ),

                          Padding(
                            padding: getPadding(bottom: 5,top: 30),
                            child: Text(
                              'ETÀ',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
                            maxLenght: 3,
                            hinttext: getCurrentLanguageValue(AGE)!,
                            controller: ageController,
                            validator: ageValidator,
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
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                            ],
                            hinttext: getCurrentLanguageValue(LAST_NAME)!,
                            controller: lastNameController,
                            validator: lastNameValidator,
                            paddingRight: 0,
                            paddingLeft: 0,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          ),


                          Padding(
                            padding: getPadding(bottom: 5,top: 30),
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
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hinttext: getCurrentLanguageValue(PHONE_NUMBER)!,
                            controller: phoneController,
                            validator: phoneValidator,
                            paddingLeft: 0,
                            paddingRight: 0,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide:
                            const BorderSide(color: background),
                          )
                        ],
                      )),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container()),
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'DATA DEL DECESSO',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            iconOnTap: iconOnTap,
                            readOnly: true,
                            hinttext: "Data del decesso",
                            controller: dateController,
                            validator: dateValidator,
                            paddingLeft: 0,
                            suffixIcon: ImagesConstants.imgCalendar,
                            isSuffixIcon: true,
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
                              'CITTÀ',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          AutocompleteWidget(
                            options: options,
                            paddingRight: 0,
                            paddingLeft: 0,
                            hintText: getCurrentLanguageValue(CITY)!,
                            filterController: filterController,
                          )
                        ],
                      )),
                ],
              ),


            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex:1,child: Container()),
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'COMUNE DI INTERESSE',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          AutocompleteWidget(
                            options: citiesOfInterestOptions,
                            paddingRight: 20,
                            paddingLeft: 0,
                            hintText: "Comune di interesse",
                            filterController: citiesController,
                          )
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'NECROLOGIO',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),

                         DropTarget(
                              onDragDone: onDragDone,
                              onDragUpdated: onDragUpdated,
                              onDragEntered: onDragEntered,
                              onDragExited: onDragExited,
                              child: child,
                            ),

                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
