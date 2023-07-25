import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/DateLabelWidget.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/texts.dart';

class FuneralDetail extends StatelessWidget {

  final String funeralDate;
  final String funeralNote;
  final String funeralHour;
  final String funeralAddress;

  final DateLabelInfo dateLabelInfo;



  const FuneralDetail({
    required this.funeralDate,
    required this.funeralNote,
    required this.funeralHour,
    required this.funeralAddress,
    required this.dateLabelInfo,
    Key? key,

  }) : super(key: key);

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
                testo: "Dati funerale",
                color: background,
                weight: FontWeight.w700,
              ),
            ),


            Row(
                children: [
                  Expanded(
                      flex: 1,
                      child:
                          DateLabelWidget(dateLabelInfo: dateLabelInfo)
                  ),
                  /*
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
                          Texth3V2(testo: funeralHour, color: black),

                        ],
                      )
                  ),
                  */
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
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
                          Texth3V2(testo: funeralAddress, color: black),


                        ],
                      )
                  ),
                ],
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
                          Texth3V2(testo: funeralNote, color: black),

                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
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
