import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/images_constants.dart';
import '../../../../constants/language.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/input.dart';
import '../../../../widgets/texts.dart';

class FuneralData extends StatelessWidget{


  final TextEditingController addressController;
  final TextEditingController timeController;
  final TextEditingController dateController;
  final TextEditingController noteController;

  final dynamic addressValidator;
  final dynamic timeValidator;
  final dynamic dateValidator;
  final dynamic noteValidator;

  final showFuneralTimePicker;
  final showFuneralDatePicker;

  const FuneralData({
    super.key,
    this.addressValidator,
    this.timeValidator,
    this.dateValidator,
    this.noteValidator,
    required this.addressController,
    required this.timeController,
    required this.dateController,
    required this.noteController,
    required this.showFuneralDatePicker,
    required this.showFuneralTimePicker,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Texth1V2(
              testo: "Dati funerale",
              color: background,
              weight: FontWeight.w700,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'DATA FUNERALE',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            iconOnTap: showFuneralDatePicker,
                            readOnly: true,
                            hinttext: getCurrentLanguageValue(FUNERAL_DATE)!,
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
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'ORARIO FUNERALE',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            readOnly: true,
                            hinttext: getCurrentLanguageValue(FUNERAL_HOUR)!,
                            controller: timeController,
                            validator: timeValidator,
                            paddingLeft: 0,
                            iconOnTap: showFuneralTimePicker,
                            paddingRight: 0,
                            suffixIcon: ImagesConstants.imgClock,
                            isSuffixIcon: true,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          )
                        ],
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5,left: 6),
                            child: Text(
                              'INDIRIZZO',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),

                          InputsV2Widget(
                            hinttext: getCurrentLanguageValue(ADDRESS)!,
                            controller: addressController,
                            validator: addressValidator,
                            paddingRight: 0,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
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
                              'NOTE FUNERALE',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            hinttext: getCurrentLanguageValue(FUNERAL_NOTE)!,
                            controller: noteController,
                            validator: noteValidator,
                            paddingLeft: 0,
                            maxLine: 5,
                            multiline: true,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          )
                        ],
                      )),
                    Expanded(flex:2,child: Container()),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}