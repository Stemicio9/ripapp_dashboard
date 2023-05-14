import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/images_constants.dart';
import '../../../../constants/language.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/input.dart';
import '../../../../widgets/texts.dart';

class WakeData extends StatelessWidget{


  final TextEditingController addressController;
  final TextEditingController timeController;
  final TextEditingController dateController;
  final TextEditingController wakeNoteController;

  final dynamic addressValidator;
  final dynamic timeValidator;
  final dynamic dateValidator;
  final dynamic wakeNoteValidator;
  final showWakeDatePicker;
  final showWakeTimePicker;

  const WakeData({
    super.key,
    this.addressValidator,
    this.timeValidator,
    this.dateValidator,
    this.wakeNoteValidator,
    required this.addressController,
    required this.timeController,
    required this.dateController,
    required this.wakeNoteController,
    required this.showWakeTimePicker,
    required this.showWakeDatePicker,
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
                testo: "Dati veglia",
                color: background,
                weight: FontWeight.w700,
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
                              'DATA VEGLIA',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            iconOnTap: showWakeDatePicker,
                            readOnly: true,
                            hinttext: getCurrentLanguageValue(WAKE_DATE)!,
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
                              'ORARIO VEGLIA',
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
                            hinttext: getCurrentLanguageValue(WAKE_HOUR)!,
                            controller: timeController,
                            validator: timeValidator,
                            paddingLeft: 0,
                            paddingRight: 0,
                            onTap: showWakeTimePicker,
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
                              'NOTE VEGLIA',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            hinttext: getCurrentLanguageValue(WAKE_NOTE)!,
                            controller: wakeNoteController,
                            validator: wakeNoteValidator,
                            paddingLeft: 0,
                            maxLine: 5,
                            multiline: true,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          )
                        ],
                      )),
                  Expanded(flex:1,child: Container()),
                  Expanded(flex:1,child: Container()),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}